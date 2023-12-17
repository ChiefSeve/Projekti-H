const map = L.map('map', maxBounds = [[0, -170], [57, -30]], minZoom =4, maxZoom = 8);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);

map.setMaxBounds(maxBounds);
map.fitBounds(maxBounds);
map.setMaxZoom(maxZoom);
map.setMinZoom(minZoom);
map.flyTo([40, -95], 5);

const redIcon = new L.Icon({
iconUrl:
  "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png",
iconSize: [25, 41],
iconAnchor: [12, 41],
popupAnchor: [1, -34]
});
const orangeIcon = new L.Icon({
  iconUrl:
    "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-orange.png",
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34]
});
const airportMarkers = L.featureGroup().addTo(map);
const locMarker = L.featureGroup().addTo(map);
const userDialog = document.getElementById('user_dialog')
const createUserSubmit = document.getElementById('create_user_submit');
const createUserInput = document.getElementById('create_user_input');
const searchForm = document.querySelector('#single');
const input = document.querySelector('input[name=icao]');
const distanceForm = document.querySelector('#calculate-distance');
const airport1 = document.querySelector('input[name=airport1]');
const airport2 = document.querySelector('input[name=airport2]');
const flyForm = document.getElementById('fly_form');
const flyButton = document.getElementById('fly_button');
const airportsArticle = document.getElementById('airports_article');
const airportsHeading = document.getElementById('airports_heading');
const airportsRefresh = document.getElementById('airports_refresh');
const airportsList = document.getElementById('airports_ul');
const tooFar = document.getElementById('too_far');
const distanceResult = document.getElementById('distance_result');
const p = document.getElementById('distance_km');
const info = document.getElementById('info');
const rightFormDiv = document.getElementById('right_forms');
const rangeNotifDialog = document.getElementById('range_notification');
const goalNotifDialog = document.getElementById('goal_notification');
const refreshNotUsedNode = document.getElementById('refresh_not_used');
let refreshNotUsed = true;
let activeUser = {
  id: '',
  frustration: '',
  location: '',
  name: '',
  weatherId: '',
  score: '',
  range: '',
  jumps: ''
};

// Styling functions

function deleteChildsOfElement(elementNode) {
  while (elementNode.firstChild) {
    elementNode.removeChild(elementNode.firstChild);
  }
}

function underlineNodeOnHover(hoverNode, targetNode) {
  hoverNode.addEventListener('mouseover', () => {
    targetNode.setAttribute('style', 'text-decoration: underline');
    hoverNode.addEventListener('mouseleave', () => {
      targetNode.removeAttribute('style');
    })
  })
  return;
}

// Rest

async function updateInfo(infoNode, playerObject) {
  // Clear previous info
  deleteChildsOfElement(infoNode);

  // Creating nodes
  const nameNode = document.createElement('p');
  const locationNode = document.createElement('p');
  const scoreNode = document.createElement('p');
  const frustrationNode = document.createElement('p');
  const weatherNode = document.createElement('p');
  const rangeNode = document.createElement('p');
  infoNode.removeAttribute('style');
  rightFormDiv.removeAttribute('style');

  // Node Array
  const nodes = [
    nameNode,
    locationNode,
    scoreNode,
    frustrationNode,
    weatherNode,
    rangeNode
  ];

  // Text contents
  try {
    const response = await fetch(`http://127.0.0.1:3000/weather?weather=${playerObject.weatherId}`);
    const weatherObject = await response.json();
    weatherNode.textContent = `Weather Goal: ${weatherObject.status} and ${weatherObject.temperature} \u00b0C`;
  }
  catch(error) {
    console.error(error);
  }
  weatherNode.setAttribute('id', 'weather_node');
  nameNode.textContent = `Name: ${playerObject.name}`;
  locationNode.textContent = `Location: ${playerObject.location}`;
  scoreNode.textContent = `Score: ${playerObject.score}`;
  frustrationNode.textContent = `Frustration: ${playerObject.frustration}`;
  rangeNode.textContent = `Range: ${playerObject.range}`;
  refreshNotUsedNode.textContent = `Not used: ${refreshNotUsed}`;

  // Appends
  nodes.forEach(node => {
    infoNode.appendChild(node);
  })
}

function updatedUserData(userData) {
  // Data comes directly from database. Not activeUser
  user = {
    id: userData.id,
    frustration: userData['frustration'],
    location: userData['location'],
    name: userData['screen_name'],
    weatherId: userData['weather_id'],
    score: userData['score'],
    range: userData['flight_range'],
    jumps: userData['jumps']
  };
  return user;
}

async function refreshAirports() {
  airportsHeading.textContent = '';
  airportsList.innerHTML = '';
  const WeatherId = activeUser.weatherId;
  // Update Heading
  try {
    const response = await fetch(`http://127.0.0.1:3000/weather?weather=${WeatherId}`);
    const weather = await response.json();
    airportsHeading.textContent = `${weather.status} and ${weather.temperature}`;
  }
  catch(error) {
    console.error(error);
  }
  // Update List
  try {
    const response = await fetch(`http://127.0.0.1:3000/airport_weather/${WeatherId}`);
    const airports = await response.json();
    airports.forEach(airport => {
      airportsList.innerHTML += `<li>${airport.ident} - ${airport.name}</li>`
    })
  }
  catch(error) {
    console.error(error);
  }
  refreshNotUsed = false;
  refreshNotUsedNode.textContent = `Not used: ${refreshNotUsed}`;
  return;
}


function rangeHalfInfo(targetNode) {
  // Creating Nodes
  const h3 = document.createElement('h3');
  const p = document.createElement('p');
  const notifClose = document.createElement('input')

  // Node Array
  const nodes = [
    h3,
    p,
    notifClose
  ]

  // Node Contents
  h3.textContent = 'Employer Notification'
  p.textContent = 'To save money and to preserve the environment, your fuel capacity has been reduced';
  notifClose.setAttribute('type', 'button');
  notifClose.setAttribute('value', 'Close');
  notifClose.addEventListener('click', () => {
    deleteChildsOfElement(targetNode);
    targetNode.close();
  })

  // Appends
  nodes.forEach(node => {
    targetNode.appendChild(node);
  });
  
  // Show Modal
  targetNode.showModal();
}

async function reachedGoalInfo(targetNode, playerData) {
  // Creating Nodes
  const h3 = document.createElement('h3');
  const p1 = document.createElement('p');
  const p2 = document.createElement('p');
  const notifClose = document.createElement('input');

  // Node list
  const nodes = [
    h3,
    p1,
    p2,
    notifClose
  ];

  // Node Contents
  h3.textContent = 'Goal Reached';
  p1.textContent = 'Your next goal is any airport with:'
  try {
    const response = await fetch(`http://127.0.0.1:3000/weather?weather=${playerData.weatherId}`);
    const weather = await response.json();
    p2.textContent = `${weather.status} & ${weather.temperature}`;
  }
  catch(error) {
    console.error(error);
  }
  notifClose.setAttribute('type', 'button');
  notifClose.setAttribute('value', 'Close');
  notifClose.addEventListener('click', () => {
    deleteChildsOfElement(targetNode);
    targetNode.close();
  })

  // Appends
  nodes.forEach(node => {
    targetNode.appendChild(node);
  });

  // Show modal
  targetNode.showModal();
}


async function GoalInfo(targetNode, playerData) {
  // Creating Nodes
  const h3 = document.createElement('h3');
  const p1 = document.createElement('p');
  const p2 = document.createElement('p');
  const notifClose = document.createElement('input');

  // Node list
  const nodes = [
    h3,
    p1,
    p2,
    notifClose
  ];

  // Node Contents
  h3.textContent = 'Goal';
  p1.textContent = 'Your next goal is any airport with:'
  try {
    const response = await fetch(`http://127.0.0.1:3000/weather?weather=${playerData.weatherId}`);
    const weather = await response.json();
    p2.textContent = `${weather.status} & ${weather.temperature}`;
  }
  catch(error) {
    console.error(error);
  }
  notifClose.setAttribute('type', 'button');
  notifClose.setAttribute('value', 'Close');
  notifClose.addEventListener('click', () => {
    deleteChildsOfElement(targetNode);
    targetNode.close();
  })

  // Appends
  nodes.forEach(node => {
    targetNode.appendChild(node);
  });

  // Show modal
  targetNode.showModal();
}


async function flyToAirport(icao) {
  deleteChildsOfElement(tooFar);
  const response = await fetch(`http://127.0.0.1:3000/fly?icao=${icao.toUpperCase()}&userId=${activeUser.id}`);
  const data =  await response.json();

  // If destination is out of range or frustration gets over 100

  if ('too_far' in data) {
    const p = document.createElement('p');
    p.textContent = 'Destination out of Range';
    tooFar.appendChild(p);
    return;
  }
  else if ('game_over' in data) {
    if (refreshNotUsed) {
      activeUser.score *= 2;
    }
    gameOverScreen(activeUser, userDialog);
    const nodes = [
      rightFormDiv
    ]
    nodes.forEach(node => {
      node.setAttribute('style', 'display: none')
    })
    return;
  }

  // If fetch returns playerdata and booleans

  const playerData = data[0];
  const booleans = data[1];
  activeUser = updatedUserData(playerData);
  await updateInfo(info, activeUser);
  locMarker.clearLayers();
  await drawOnLocation(activeUser.location);
  
  if (booleans.reached_goal == true) {
    reachedGoalInfo(goalNotifDialog, activeUser);
  }

  if (booleans.range_changed == true) {
    switch(activeUser.range) {
      case 2778:
        break;
      case 1389 || 858:
        rangeHalfInfo(rangeNotifDialog);
        break;
      /* case 858:
        rangeHalfInfo(rangeNotifDialog);
        break; */
    }
}

  
//   Jos backend onnistuu eli sijainti muuttuu, vaihetaan kartalla käyttäjän sijainti punaisella merkillä. Eli poistetaan Nykynen punainen merkki ja laitetaan tilalle sininen.
//   Paikka mihin lennetään, sieltä poistetaan sininen merkki ja laitetaan tilalle punainen
}

async function drawOnLocation(icao){
  const response = await fetch('http://127.0.0.1:3000/airport/' + icao);
  const locData = await response.json();
  const markerplayer = L.marker([locData.latitude_deg, locData.longitude_deg], {
    icon: redIcon
  }).addTo(map);
  locMarker.addLayer(markerplayer);
  const flightcircleplayer = L.circle([locData.latitude_deg, locData.longitude_deg], {
    radius: activeUser.range * 1000,
  });
  locMarker.addLayer(flightcircleplayer);
}

async function createUser(){
  createUserSubmit.addEventListener('click', async(evt) => {
    evt.preventDefault();
    try {
      const player = await fetch(`http://localhost:3000/create_user?screen_name=${createUserInput.value}`);
      const player_json = await player.json();
      activeUser = updatedUserData(player_json);
      await updateInfo(info, activeUser);
    }
    catch(error) {
      console.error(error);
    }

    // Delete form

    /* const userDialog = document.getElementById('user_dialog'); */
    deleteChildsOfElement(userDialog);
    locMarker.clearLayers();
    await drawOnLocation(activeUser.location);
    userDialog.close();

    GoalInfo(goalNotifDialog, activeUser);
  })
}


async function createUserSelectForm(userData){
  const userForm = document.createElement('form');
  const userLabel = document.createElement('h3');
  const userSelect  = document.createElement('select');
  const userButton  = document.createElement('button');
  userForm.setAttribute('id','selectUser');
  userLabel.innerHTML = 'Select user';
  userSelect.setAttribute('id','userDropDown');
  userButton.setAttribute('id', 'selectUserSubmit')
  userButton.setAttribute('type', 'button')
  userButton.innerHTML = 'SUBMIT';
  userButton.setAttribute('onclick','selectUser()')
  userForm.appendChild(userLabel);
  userForm.appendChild(userSelect);
  userForm.appendChild(userButton);
  userDialog.appendChild(userForm);
  if (userData !== 'no data') {
     userData.forEach(user => {
    const option = document.createElement('option');
    option.value = user.id;
    option.innerHTML = user.screen_name;
    userSelect.appendChild(option)
  });
  userButton.addEventListener('click', () => {
    userDialog.close();
  });
  }

  // Styling
  underlineNodeOnHover(userForm, userLabel);
}


async function selectUser() {
  const userSelect = document.getElementById('userDropDown');
  const userID = parseInt(userSelect.value);
  activeUser.id = userID;
  try {
    const response = await fetch(`http://localhost:3000/getUser?id=${userID}`);
    const playerData = await response.json();
    activeUser = updatedUserData(playerData);
    updateInfo(info, activeUser);
  }
  catch(error) {
    console.error(error);
  }

  // Delete form
  deleteChildsOfElement(userDialog);
  locMarker.clearLayers();
  setTimeout(async() => {await drawOnLocation(activeUser.location)}, 50);
  GoalInfo(goalNotifDialog, activeUser);
}

function gameOverScreen(playerData, dialogNode) {
  // Creating of nodes
  const gameOverNode = document.createElement('h3');
  const scoreModifierDivNode = document.createElement('div');
  const playerScoreNode = document.createElement('p');
  const scoreModifierHeaderNode = document.createElement('p');
  const scoreModifiersNode = document.createElement('p');
  locMarker.clearLayers();
  map.flyTo([40, -95], 4);
  map.dragging.disable();

  // Node Array
  const nodes = [
    playerScoreNode,
    scoreModifierDivNode,
    gameOverNode
  ];

  // Node contents
  gameOverNode.textContent = 'Game Over';
  gameOverNode.setAttribute('id', 'game_over_h3');
  scoreModifierHeaderNode.textContent = 'Score Modifiers:';
  scoreModifierDivNode.setAttribute('id', 'game_over_div');

  if (refreshNotUsed == true) {
    scoreModifiersNode.innerHTML = 'Cheat List not Used: x2';
  }
  else {
    scoreModifiersNode.innerHTML = 'Cheat List Used: x1';
  }

  playerScoreNode.textContent = `Final Score: ${playerData.score}`;
  playerScoreNode.setAttribute('id', 'game_over_p');

  // Appends
  scoreModifierDivNode.appendChild(scoreModifierHeaderNode);
  scoreModifierDivNode.appendChild(scoreModifiersNode);
  nodes.forEach(node => {
    dialogNode.appendChild(node);
  });

  dialogNode.showModal();
}

window.addEventListener('load', async function(evt) {
  evt.preventDefault();
  const respAir = await fetch('http://127.0.0.1:3000/airportsAll/');
  const airportsData = await respAir.json();
  for (const airport of airportsData) {
    const weatherResp = await fetch(`http://127.0.0.1:3000/weather?weather=${airport.weather_id}`);
    const weatherData = await weatherResp.json();
    const marker = L.marker([airport.latitude_deg, airport.longitude_deg]).
      addTo(map).
    bindPopup(`${airport.name}(${airport.ident})`+ '<br>' + `Olosuhde: ${weatherData.status}` + '<br>' + `Lämpötila: ${weatherData.temperature}C`);
  airportMarkers.addLayer(marker);
  }
  const usersResp = await fetch('http://127.0.0.1:3000/getUser/all');
  const userData = await usersResp.json();
  // Create create/select user form
  if (userData){
    await createUserSelectForm(userData);
    await createUser();
  } else {
    await createUser();
  }
  userDialog.showModal();

  // Styling
  const createUserForm = document.getElementById('create_user');
  const h3 = document.querySelector('#create_user h3');
  underlineNodeOnHover(createUserForm, h3);
});


// Search by ICAO
searchForm.addEventListener('submit', async (evt) => {
  evt.preventDefault();
  const icao = input.value;
  const response = await fetch('http://127.0.0.1:3000/airport/' + icao);
  const airport = await response.json();
  // remove possible other markers

  // add marker
  const markerorange = L.marker([airport.latitude_deg, airport.longitude_deg], {
    icon: orangeIcon
  }).
      addTo(map).
      bindPopup(`${airport.name}(${airport.ident})`).
      openPopup();
  airportMarkers.addLayer(markerorange);

  const flightcircle = L.circle([airport.latitude_deg, airport.longitude_deg], {
    radius: activeUser.range * 1000,
    //radius väliaikainen, muutetaan myöhemmin ottamaan flight_range
    color: "red"
  });
  airportMarkers.addLayer(flightcircle);

  markerorange.getPopup().on('remove', function(){
    airportMarkers.removeLayer(markerorange);
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
  p.innerText = Math.floor(distance) + 'km';
  distanceResult.appendChild(p);
});

// Fly button
flyButton.addEventListener('click', async(evt) => {
  evt.preventDefault();
  const icao_input = document.querySelector('input[name="dest_airport"]');
  await flyToAirport(icao_input.value);
  document.querySelector('input[name="dest_airport"]').value = '';

})

// Airports list
airportsRefresh.addEventListener('click', async() => {
  refreshAirports();
})



// Info Button function
const infoBox = document.getElementById('infoBox');
const infoBoxButton = document.getElementById('infoBoxButton');
function openInfoBox(){
  infoBox.removeAttribute('style');
  infoBoxButton.setAttribute('style', 'display:none');

}

function closeInfoBox() {
  infoBox.setAttribute('style', 'display:none');
  infoBoxButton.removeAttribute('style');
}
