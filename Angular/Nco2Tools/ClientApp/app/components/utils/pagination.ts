import { Table } from "./table";
import { Input } from "@angular/core";
export class Pagination<T extends Table> {

    list: T[] = [];
    filteredItems: T[] = [];
    pages: number = 4;
    pageSize: number = 5;
    pageNumber: number = 0;
    currentIndex: number = 1;
    items: T[] = [];
    pagesIndex: Array<number> = [];
    pageStart: number = 1;

    @Input()
    inputName: string = '';

    constructor() { };

    fill(_items: T[], page_size: number) {
        this.filteredItems = _items;
        this.list = _items;
        this.pageSize = page_size;
        this.init();
    };

    init() {
        this.currentIndex = 1;
        this.pageStart = 1;
        this.pages = 4;

        this.pageNumber = parseInt("" + (this.filteredItems.length / this.pageSize));
        if (this.filteredItems.length % this.pageSize != 0) {
            this.pageNumber++;
        }

        if (this.pageNumber < this.pages) {
            this.pages = this.pageNumber;
        }

        this.refreshItems();
    }

    FilterByName() {
        
        this.filteredItems = [];
        if (this.inputName != "") {
            this.list.forEach(element => {
                element.row.forEach(row => {
                    if (row.toUpperCase().indexOf(this.inputName.toUpperCase()) >= 0) {
                        this.filteredItems.push(element);
                    }
                });
            });
        } else {
            this.filteredItems = this.list;
        }
        this.init();
    }

    fillArray(): any {
        var obj = new Array();
        for (var index = this.pageStart; index < this.pageStart + this.pages; index++) {
            obj.push(index);
        }
        return obj;
    }

    refreshItems() {
        this.items = this.filteredItems.slice((this.currentIndex - 1) * this.pageSize, (this.currentIndex) * this.pageSize);
        this.pagesIndex = this.fillArray();
    }

    prevPage() {
        if (this.currentIndex > 1) {
            this.currentIndex--;
        }
        if (this.currentIndex < this.pageStart) {
            this.pageStart = this.currentIndex;
        }
        this.refreshItems();
    }

    nextPage() {
        if (this.currentIndex < this.pageNumber) {
            this.currentIndex++;
        }
        if (this.currentIndex >= (this.pageStart + this.pages)) {
            this.pageStart = this.currentIndex - this.pages + 1;
        }

        this.refreshItems();
    }

    setPage(index: number) {
        this.currentIndex = index;
        this.refreshItems();
    }

    firstPage() {
        this.currentIndex = 1;

        if (this.currentIndex < this.pageStart) {
            this.pageStart = this.currentIndex;
        }
        this.refreshItems();
    }

    lastPage() {
        this.currentIndex = this.pageNumber;
        
        if (this.currentIndex >= (this.pageStart + this.pages)) {
            this.pageStart = this.currentIndex - this.pages + 1;
        }
        this.refreshItems();
    }

}