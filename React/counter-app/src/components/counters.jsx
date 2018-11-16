import React, { Component } from "react";
import Counter from "./counter";

class Counters extends Component {
  state = {
    counters: [
      { id: 1, value: 4 },
      { id: 2, value: 0 },
      { id: 3, value: 0 },
      { id: 4, value: 0 },
      { id: 5, value: 0 }
    ]
  };

  handleDelete = i => {
    const counters = this.state.counters.filter(c => c.id !== i);
    this.setState({ counters });
    console.log("Deleted item #" + i);
  };

  handleReset = _ => {
    const counters = this.state.counters.map(c => {
      c.value = 0;
      return c;
    });
    this.setState({ counters });
    };
  
  handleCounterUpdate = (i,step) => {
    const counters = this.state.counters.map(c => {
        if(c.id ===i){
            let newValue = c.value + step
            c.value = newValue>=0? newValue:0;
        }
        return c;
      });

      this.setState({counters});
    };


  render() {
    return (
      <div>
        <button
          className="btn btn-sm btn-primary m-2"
          onClick={this.handleReset}
        >
          Reset
        </button>
        {this.state.counters.map(c => (
          <Counter
            key={c.id}
            counter={c}
            onDelete={_ => this.handleDelete(c.id)}
            onUpdate={step=> this.handleCounterUpdate(c.id,step)}
          >
            <h6>{c.id}.</h6>
          </Counter>
        ))}
      </div>
    );
  }
}

export default Counters;
