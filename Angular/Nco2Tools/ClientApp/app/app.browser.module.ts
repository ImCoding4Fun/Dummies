import { NgModule /*, NO_ERRORS_SCHEMA */ } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppModuleShared } from './app.shared.module';
import { AppComponent } from './components/app/app.component';

//import { MDBBootstrapModule } from 'angular-bootstrap-md';

@NgModule({
    bootstrap: [ AppComponent ],
    imports: [
        BrowserModule,
        AppModuleShared/*,
        MDBBootstrapModule.forRoot()*/
    ],
    providers: [
        { provide: 'BASE_URL', useFactory: getBaseUrl }
    ]/*,
    schemas: [NO_ERRORS_SCHEMA]*/
})
export class AppModule {
}

export function getBaseUrl() {
    return document.getElementsByTagName('base')[0].href;
}
