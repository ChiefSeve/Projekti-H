// const map = L.map('map').setView([44.08, -99.71], 5);
// L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
//   attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
// }).addTo(map);
const map = L.map('map', maxBounds = [[0, -170], [57, -30]], minZoom =5, maxZoom = 8)
.setView([44.08, -99.71], 6) ;
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);

map.setMaxBounds(maxBounds)
map.fitBounds(maxBounds)
map.setMinZoom(minZoom)
map.setMaxZoom(maxZoom)

const redIcon = new L.Icon({
iconUrl:
  "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png",
//shadowUrl:
  //"https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png",
iconSize: [25, 41],
iconAnchor: [12, 41],
popupAnchor: [1, -34]
});
const airportMarkers = L.featureGroup().addTo(map);
const userDialog = document.getElementById('user_dialog')
const createUserSubmit = document.getElementById('create_user_submit');
const createUserInput = document.getElementById('create_user_input');
const searchForm = document.querySelector('#single');
const input = document.querySelector('input[name=icao]');
const distanceForm = document.querySelector('#calculate-distance');
const airport1 = document.querySelector('input[name=airport1]');
const airport2 = document.querySelector('input[name=airport2]');
const flyButton = document.getElementById('fly_button');
const distanceResult = document.getElementById('distance_result');
const p = document.getElementById('distance_km');
const activeUser = {
  id: '',
  location: '',
  name: ''
};


function deleteChildsOfElement(elementNode) {
  while (elementNode.firstChild) {
    elementNode.removeChild(elementNode.firstChild);
  }
}


async function flyToAirport(icao) {
  console.log(icao, 'foobar icao')
  const response = await fetch(`http://127.0.0.1:3000/fly?icao=${icao}&userId=${activeUser.id}`);
  const response_json =  response.json();
  console.log(response_json);
//   Jos backend onnistuu eli sijainti muuttuu, vaihetaan kartalla käyttäjän sijainti punaisella merkillä. Eli poistetaan Nykynen punainen merkki ja laitetaan tilalle sininen.
//   Paikka mihin lennetään, sieltä poistetaan sininen merkki ja laitetaan tilalle punainen
}

async function createUser(){
  createUserSubmit.addEventListener('click', async(evt) => {
    evt.preventDefault();
    try {
      const player = await fetch(`http://localhost:3000/create_user?screen_name=${createUserInput.value}`);
      const player_json = await player.json();
      // console.log(player_json);
      activeUser.id = player_json['id'];
    }
    catch(error) {
      console.error(error);
    }
    activeUser.name = createUserInput.value;

    // Delete form

    const userDialog = document.getElementById('user_dialog');
    deleteChildsOfElement(userDialog);
  })
}


async function createUserSelectForm(userData){
  const userForm = document.createElement('form');
  const userLabel = document.createElement('label');
  const userSelect  = document.createElement('select');
  const userButton  = document.createElement('button');
  userForm.setAttribute('id','selectUser');
  userLabel.innerHTML = 'Valitse käyttäjä';
  userSelect.setAttribute('id','userDropDown');
  userButton.setAttribute('id', 'selectUserSubmit')
  userButton.setAttribute('type', 'button')
  userButton.innerHTML = 'SUBMIT';
  userButton.setAttribute('onclick','selectUser()')
  userForm.appendChild(userLabel);
  userForm.appendChild(userSelect);
  userForm.appendChild(userButton);
  userDialog.appendChild(userForm);
  userData.forEach(user => {
    const option = document.createElement('option');
    option.value = user.id;
    option.innerHTML = user.screen_name;
    userSelect.appendChild(option)

  });
}


async function selectUser() {
  const userSelect = document.getElementById('userDropDown');
  const userID = parseInt(userSelect.value);
  activeUser.id = userID;
  try {
    const response = await fetch(`http://localhost:3000/getUser?id=${userID}`);
    const playerData = await response.json();
    console.log(playerData);
    activeUser.name = playerData.screen_name;
  }
  catch(error) {
    console.error(error);
  }

  // Delete form
  const userDialog = document.getElementById('user_dialog');
  deleteChildsOfElement(userDialog);
}

window.addEventListener('load', async function(evt) {
  evt.preventDefault();
  const respAir = await fetch('http://127.0.0.1:3000/airportsAll/');
  const airportsData = await respAir.json();
  airportsData.forEach(airport =>{
    const airportIcao = airport.ident
    const marker = L.marker([airport.latitude_deg, airport.longitude_deg]).
      addTo(map).
      bindPopup(`${airport.name}(${airport.ident})`);
  airportMarkers.addLayer(marker);
  })
  const usersResp = await fetch('http://127.0.0.1:3000/getUser/all');
  const userData = await usersResp.json();
  // Create create/select user form
  if (userData){
    console.log('userData success');
    await createUserSelectForm(userData);
    await createUser();
  } else {
    console.log('no data');
    await createUser();
  }
});


// Search by ICAO
searchForm.addEventListener('submit', async (evt) => {
  evt.preventDefault();
  const icao = input.value;
  const response = await fetch('http://127.0.0.1:3000/airport/' + icao);
  const airport = await response.json();
  // remove possible other markers
  // add marker
  const markerred = L.marker([airport.latitude_deg, airport.longitude_deg], {
    icon: redIcon
  }).
      addTo(map).
      bindPopup(`${airport.name}(${airport.ident})`+'<br><div id="button_div"></div>').
      openPopup();

  airportMarkers.addLayer(markerred);

  const flightcircle = L.circle([airport.latitude_deg, airport.longitude_deg], {
    radius: 2778000
    //radius väliaikainen, muutetaan myöhemmin ottamaan flight_range
  });
  airportMarkers.addLayer(flightcircle);

  const flyButton = document.createElement('button');
  const buttonDiv = document.getElementById('button_div');
  flyButton.setAttribute('id', 'fly_button');
  flyButton.setAttribute('type', 'button');
  flyButton.innerHTML = 'FLY';
  flyButton.addEventListener('click', function(){
    flyToAirport(icao)
  });
  buttonDiv.appendChild(flyButton);
  markerred.getPopup().on('remove', function(){
    airportMarkers.removeLayer(markerred);
    airportMarkers.removeLayer(flightcircle);
  });


  // pan map to selected airport
  map.flyTo([airport.latitude_deg, airport.longitude_deg]);
});

// Calculate distance between airports


distanceForm.addEventListener('submit', async(evt) => {
  evt.preventDefault();
  p.innerText = '';
  const airport1Icao = airport1.value;
  const airport2Icao = airport2.value;
  const response = await fetch(`http://127.0.0.1:3000/calculateDistance?from=${airport1Icao}&to=${airport2Icao}`);
  const distance =await response.json();
  console.log(distance, 'distance')
  p.innerText = Math.floor(distance) + 'km';
  distanceResult.appendChild(p);
});

// Fly
