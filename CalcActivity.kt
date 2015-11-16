package aldo.kcalc

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.TextView

class CalcActivity : Activity() , View.OnClickListener {

    //TODO 2. Get rid off not significant digits in result

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_calc)

        findViewById(R.id.addition_button).setOnClickListener(this)
        findViewById(R.id.subtraction_button).setOnClickListener(this)
        findViewById(R.id.multiply_button).setOnClickListener(this)
        findViewById(R.id.division_button).setOnClickListener(this)
        findViewById(R.id.exp_button).setOnClickListener(this)
        findViewById(R.id.average_button).setOnClickListener(this)
        findViewById(R.id.mode_button).setOnClickListener(this)
        findViewById(R.id.cancel_button).setOnClickListener(this)

    }

    override fun onClick(view: View) {
        var n1 : EditText = findViewById(R.id.number_0_edit) as EditText
        var n2 : EditText = findViewById(R.id.number_1_edit) as EditText

        n1.setBackgroundResource(if (n1.text.toString().isBlank()) R.drawable.error_style else R.drawable.default_style)
        n2.setBackgroundResource(if (n2.text.toString().isBlank()) R.drawable.error_style else R.drawable.default_style)

        var mode : Button = findViewById(R.id.mode_button) as Button

        if(view.id ==R.id.mode_button) {
            n1.setBackgroundResource(R.drawable.default_style)
            n2.setBackgroundResource(R.drawable.default_style)
            toggleMode(mode.text.toString())
        }
        var result: TextView = findViewById(R.id.tvResult) as TextView
        if (n1.text.toString().isBlank() || n2.text.toString().isBlank() ) {
            result.text = ""
            return
        }

        if(n1.text.toString().toInt() == 27 && n2.text.toString().toInt() == 9) {
                result.text = getString(R.string.easter_egg)
        }
        else {
            when (view.id)
            {
                R.id.addition_button    -> result.text = (n1.text.toString().toDouble() + n2.text.toString().toDouble()).toString()
                R.id.subtraction_button -> result.text = (n1.text.toString().toDouble() - n2.text.toString().toDouble()).toString()
                R.id.multiply_button    -> result.text = (n1.text.toString().toDouble() * n2.text.toString().toDouble()).toString()
                R.id.division_button    -> result.text = (n1.text.toString().toDouble() / n2.text.toString().toDouble()).toString()
                R.id.exp_button         -> result.text = (Math.pow(n1.text.toString().toDouble(), n2.text.toString().toDouble())).toString()
                R.id.average_button     -> result.text = ((n1.text.toString().toDouble() + n2.text.toString().toDouble())/2).toString()
                R.id.cancel_button      ->
                                            {
                                                n1.setText("")
                                                n2.setText("")
                                                n1.setBackgroundResource(R.drawable.default_style)
                                                n2.setBackgroundResource(R.drawable.default_style)
                                                result.text = ""
                                            }
                else                    -> result.text = ""
            }
        }
    }

    private fun toggleMode(mode: String)
    {
        if(mode == getString(R.string.mode_button_scientific) )
        {
            (findViewById(R.id.mode_button) as Button).text = getString(R.string.mode_button_standard)
            (findViewById(R.id.exp_button) as Button).visibility = View.VISIBLE
            (findViewById(R.id.average_button) as Button).visibility = View.VISIBLE
        }
        else
        {
            (findViewById(R.id.mode_button) as Button).text  = getString(R.string.mode_button_scientific)
            (findViewById(R.id.exp_button) as Button).visibility = View.GONE
            (findViewById(R.id.average_button) as Button).visibility = View.GONE
        }
    }
}
