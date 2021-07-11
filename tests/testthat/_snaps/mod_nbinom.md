# mod_nbinom_ui

    Code
      mod_nbinom_ui("nbplot")
    Output
      <div class="container-fluid">
        <h2>Negative Binomial Distribution</h2>
        <div class="row">
          <div class="col-sm-4">
            <form class="well" role="complementary">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="nbplot-size-label" for="nbplot-size">Size Paramater</label>
                <input class="js-range-slider" id="nbplot-size" data-skin="shiny" data-min="0.2" data-max="10" data-from="1" data-step="0.1" data-grid="true" data-grid-num="9.8" data-grid-snap="false" data-prettify-separator="," data-prettify-enabled="true" data-keyboard="true" data-data-type="number"/>
              </div>
              <div class="form-group shiny-input-container">
                <label class="control-label" id="nbplot-prob-label" for="nbplot-prob">Prob Paramater</label>
                <input class="js-range-slider" id="nbplot-prob" data-skin="shiny" data-min="0.01" data-max="1" data-from="0.5" data-step="0.01" data-grid="true" data-grid-num="9.9" data-grid-snap="false" data-prettify-separator="," data-prettify-enabled="true" data-keyboard="true" data-data-type="number"/>
              </div>
              <div class="form-group shiny-input-container">
                <label class="control-label" id="nbplot-mu-label" for="nbplot-mu">Mu Paramater</label>
                <input id="nbplot-mu" type="text" class="form-control" value="1.0"/>
              </div>
              <div id="nbplot-fix" class="form-group shiny-input-radiogroup shiny-input-container" role="radiogroup" aria-labelledby="nbplot-fix-label">
                <label class="control-label" id="nbplot-fix-label" for="nbplot-fix">Fix</label>
                <div class="shiny-options-group">
                  <div class="radio">
                    <label>
                      <input type="radio" name="nbplot-fix" value="size" checked="checked"/>
                      <span>size</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="nbplot-fix" value="mu"/>
                      <span>mu</span>
                    </label>
                  </div>
                </div>
              </div>
              <button id="nbplot-update" type="button" class="btn btn-default action-button">Update parameters</button>
              <div class="form-group shiny-input-container">
                <label class="control-label" id="nbplot-quantile-label" for="nbplot-quantile">Coverage of quantile</label>
                <div>
                  <select id="nbplot-quantile"><option value="0.99" selected>0.99</option>
      <option value="0.999">0.999</option>
      <option value="0.9999">0.9999</option>
      <option value="0.99999">0.99999</option></select>
                  <script type="application/json" data-for="nbplot-quantile" data-nonempty="">{"plugins":["selectize-plugin-a11y"]}</script>
                </div>
              </div>
              <button id="nbplot-reset" type="button" class="btn btn-default action-button">Reset parameters</button>
            </form>
          </div>
          <div class="col-sm-8" role="main">
            <div id="nbplot-plot" class="shiny-plot-output" style="width:100%;height:400px;"></div>
          </div>
        </div>
      </div>

