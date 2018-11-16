import React, { Component } from "react";

class Counter extends Component {
 
  render() {
    return (
      <React.Fragment>
        <div className="d-flex flex-nowrap bd-highlight">
            <div className="p-2 bd-highlight">
            {this.props.children}
            </div>
            <div className="p-2 bd-highlight">
              <span className={this.getBadgeClasses()}>{this.formatCount()}</span>
            </div>
            <div className="p-2 bd-highlight">
              <button
                className="btn btn-secondary btn-sm"
                onClick={_ =>this.props.onUpdate(+1)}
              >
                +
              </button>
            </div>
            <div className="p-2 bd-highlight">
              <button
                className="btn btn-secondary btn-sm"
                onClick={_ =>this.props.onUpdate(-1)}
              >
                -
              </button>
              
            </div>
            <div className="p-2 bd-highlight">
              <button className="btn btn-secondary btn-sm btn-danger" onClick={this.props.onDelete}>Delete</button>
            </div>
        </div>
      </React.Fragment>
    );
  }

  getBadgeClasses() {
    let classes = "badge m-2 badge-";
    classes += this.props.counter.value === 0 ? "warning" : "primary";
    return classes;
  }

  formatCount() {
    const { value } = this.props.counter;
    return value === 0 ? "Zero" : value;
  }
}

export default Counter;
