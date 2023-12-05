// const map = L.map('map').setView([44.08, -99.71], 5);
// L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
//   attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
// }).addTo(map);
const map = L.map('map', maxBounds = [[25, -125], [50, -66]], minZoom =5, maxZoom = 8)
.setView([44.08, -99.71], 5) ;
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
shadowUrl:
  "https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png",
iconSize: [25, 41],
iconAnchor: [12, 41],
popupAnchor: [1, -34],
shadowSize: [41, 41]
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
const activeUser = {
  id: ''
};






async function createUser(){
  createUserSubmit.addEventListener('click', async(evt) => {
    evt.preventDefault();
    try {
      await fetch(`http://localhost:3000/create_user?screen_name=${createUserInput.value}`)
    }
    catch(error) {
      console.error(error);
    }
    activeUser.name = createUserInput.value;
    userDialog.close();
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

window.addEventListener('load', async function(evt) {
  evt.preventDefault();
  const respAir = await fetch('http://127.0.0.1:3000/airportsAll/');
  const airportsData = await respAir.json();
  airportsData.forEach(airport =>{
    const marker = L.marker([airport.latitude_deg, airport.longitude_deg]).
      addTo(map).
      bindPopup(`${airport.name}(${airport.ident})`+'<br/><button id="fly_button">hallo</button>');
  airportMarkers.addLayer(marker);
  })
  const usersResp = await fetch('http://127.0.0.1:3000/getUsers');
  const userData = await usersResp.json();
  if (userData){
    await createUserSelectForm(userData);
    await createUser();
  } else {
    await createUser();
  }
});

// User selection/creation dialog box


// Select user

function selectUser(){
  const selectUserSubmit = document.getElementById('selectUserSubmit');
  const userDropDown = document.getElementById('userDropDown');
  activeUser.id = userDropDown.value;
  userDialog.close();

}


// Search by ICAO ******************************


searchForm.addEventListener('submit', async (evt) => {
  evt.preventDefault();
  const icao = input.value;
  const response = await fetch('http://127.0.0.1:3000/airport/' + icao);
  const airport = await response.json();
  // remove possible other markers
  // add marker
  const marker = L.marker([airport.latitude_deg, airport.longitude_deg], {
    icon: redIcon
  }).
      addTo(map).
      bindPopup(`${airport.name}(${airport.ident})`).
      openPopup();
  airportMarkers.addLayer(marker);
  // pan map to selected airport
  map.flyTo([airport.latitude_deg, airport.longitude_deg]);
});

// Calculate distance between airports


distanceForm.addEventListener('submit', async(evt) => {
  evt.preventDefault();
  const airport1Icao = airport1.value;
  const airport2Icao = airport2.value;
  const response = await fetch(`http://127.0.0.1:3000/calculateDistance?from=${airport1Icao}&to=${airport2Icao}`);
  const distance =await response.json();
  console.log(distance, 'distance')

  const distanceResult = document.getElementById('distance_result');
  const p = document.createElement('p');
  p.innerText = Math.floor(distance) + 'km';
  distanceResult.appendChild(p);
});

// Fly


airportMarkers.addEventListener('click', async(evt) => {
  // console.log(evt);
  const airportLat = evt.latlng.lat;
  const airportLng = evt.latlng.lng;
  const response = await fetch(`http://127.0.0.1:3000/fly?lat=${airportLat}&lng=${airportLng}`);
  const response_json = await response.json();
  // console.log(response_json);
});