import { Loader } from "@googlemaps/js-api-loader";
let Hooks = {};

Hooks.Map = {
  mounted() {
    const loader = new Loader({
      apiKey: "your google mapi api key",
      version: "weekly",
      language: "en"
    });
    loader.load().then(() => {
      const map = new google.maps.Map(document.getElementById("map"), {
        center: {lat: 29.514552, lng: -98.502849},
        zoom: 12
      });
      window.map = map;
    });

    this.handleEvent("created_point", (point) => {
      const marker = new google.maps.Marker({
        position: {lat: point.lat, lng: point.lng},
        animation: google.maps.Animation.DROP
      });
      marker.setMap(window.map)
      window.markers = [...window.markers, {...point, marker: marker}]
    })
  }
};

export default Hooks;
