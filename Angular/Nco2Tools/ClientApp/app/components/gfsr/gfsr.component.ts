import { Component, Inject, OnInit, OnChanges, Input, SimpleChange } from '@angular/core';
import { Http } from '@angular/http';
import { Pagination } from '../utils/pagination';
import { Table } from '../utils/table';

@Component({
    selector: 'fetchdata',
    templateUrl: './gfsr.component.html',
    styleUrls: ['./gfsr.component.css']
})
export class GfsrComponent extends Pagination<CalculationSet> implements OnInit, OnChanges {

    ngOnInit(): void {
        this.GetCalculationSets();
    }

    private _http: Http;
    private _baseUrl: string;
    private v: boolean = false;

    @Input()
    public calcSets: CalculationSet[] = [];
  
    constructor(http: Http, @Inject('BASE_URL') baseUrl: string) {
        super();
        this._http = http;
        this._baseUrl = baseUrl;
    }

    GetCalculationSets() {
        
        this._http.get(this._baseUrl + 'api/Gfsr/CalcutationSets').subscribe(result => {
            this.calcSets = result.json() as CalculationSet[];
            this.fill(this.calcSets, 5);
        }, error => console.error(error));
    }

    SubmitData(id: number) {
        let index: number = id-1
        this.calcSets[index].enabled = !this.calcSets[index].enabled;
        
        this._http.post(this._baseUrl + 'api/Gfsr/Unit/', this.calcSets).subscribe(
            () => { },
            error => {
                return console.error(error);
            }
        );
    }

    ngOnChanges(changes: { [propName: string]: SimpleChange }): void{

        for (let propName in changes) {
            let change = changes[propName];
            let curVal = JSON.stringify(change.currentValue);
            let prevVal = JSON.stringify(change.previousValue);

            console.log(curVal);
            console.log(prevVal);
        }
    }

    trackQuestion(index: number, calcSet: CalculationSet) {
        return index.toString();
        // you can implement custom logic here using the question
    }
}

interface CalculationSet extends Table {
    id: number;
    enabled: boolean;
    name: string;
}
