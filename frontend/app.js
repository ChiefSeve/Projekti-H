const map = L.map('map').setView([44.08, -99.71], 4);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);

const airportMarkers = L.featureGroup().addTo(map);

// Search by ICAO ******************************

window.addEventListener('load', async function(evt) {
  evt.preventDefault();
  const resp = await fetch('http://127.0.0.1:3000/airportsAll/');
  const airportsData = await resp.json();
  airportsData.forEach(airport =>{
    const marker = L.marker([airport.latitude_deg, airport.longitude_deg]).
      addTo(map).
      bindPopup(`${airport.name}(${airport.ident})`);
  airportMarkers.addLayer(marker);
  })

});

const searchForm = document.querySelector('#single');
const input = document.querySelector('input[name=icao]');
searchForm.addEventListener('submit', async (evt) => {
  evt.preventDefault();
  const icao = input.value;
  const response = await fetch('http://127.0.0.1:3000/airport/' + icao);
  const airport = await response.json();
  // remove possible other markers
  // add marker
  const marker = L.marker([airport.latitude_deg, airport.longitude_deg]).
      addTo(map).
      bindPopup(`${airport.name}(${airport.ident})`).
      openPopup();
  airportMarkers.addLayer(marker);
  // pan map to selected airport
  map.flyTo([airport.latitude_deg, airport.longitude_deg]);
});

const distanceForm = document.querySelector('#calculate-distance');
const airport1 = document.querySelector('input[name=airport1]');
const airport2 = document.querySelector('input[name=airport2]');

distanceForm.addEventListener('submit', async(evt) => {
  evt.preventDefault();
  const airport1Icao = airport1.value;
  const airport2Icao = airport2.value;
  const response = await fetch(`http://127.0.0.1:3000/calculateDistance?from=${airport1Icao}&to=${airport2Icao}`);
  const distance =await response.json();
  console.log(distance, 'distance')
});