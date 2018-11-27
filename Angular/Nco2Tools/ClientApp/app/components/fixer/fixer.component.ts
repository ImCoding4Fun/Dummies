import { Component, Inject, OnInit } from '@angular/core';
import { Http } from '@angular/http';
import { Pagination } from '../utils/pagination';
import { Table } from '../utils/table';

@Component({
    selector: 'fetchdata',
    templateUrl: './fixer.component.html',
    styleUrls: ['./fixer.component.css']
})
export class FixerComponent extends Pagination<Rate> implements OnInit {

    ngOnInit(): void {
        this.GetLastExchangeRates('EUR');
    }

    private _http: Http;
    private _baseUrl: string;
    public amount: number = 10;
    public rates: Rate[] = [];

    //public baseCurrencies: Array<string> = ['EUR', 'USD', 'CHF'];
    public selectedCurrency: string = 'EUR';

    constructor(http: Http, @Inject('BASE_URL') baseUrl: string) {
        super();
        this._http = http;
        this._baseUrl = baseUrl;
    }

    GetLastExchangeRates(baseCurrency: string) {
        this.selectedCurrency = baseCurrency;
        this._http.get(this._baseUrl + 'api/Fixer/LastExchangeRates/' + baseCurrency).subscribe(result => {
            this.rates = result.json() as Rate[];
            this.fill(this.rates, 5);
        }, error => console.error(error));
    }
}

interface Rate extends Table {
    currency: string;
    exchange: number;
}
