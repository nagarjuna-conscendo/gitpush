import { LightningElement,track } from 'lwc';
import getWeatherData from '@salesforce/apex/apitestingfinal.getWeatherData';   
export default class Lwcapicomponent extends LightningElement {
 @track weather;
    @track error;
    @track loading = true;

    connectedCallback() {
        this.fetchWeather();
    }

    fetchWeather() {
        getWeatherData()
            .then(result => {
                this.weather = result;
                this.error = undefined;
                this.loading = false;
            })
            .catch(error => {
                this.error = error.body ? error.body.message : error.message;
                this.weather = undefined;
                this.loading = false;
            });
    }

    get isLoaded() {
        return this.weather && this.weather.current_weather;
    }
}