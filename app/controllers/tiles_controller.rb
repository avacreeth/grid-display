class TilesController < ApplicationController
  # GET /tiles
  # GET /tiles.json
  def index
    @tiles = Tile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tiles }
    end
  end

  # GET /tiles/1
  # GET /tiles/1.json
  def show
    @tile = Tile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tile }
    end
  end

  # GET /tiles/new
  # GET /tiles/new.json
  def new
    @tile = Tile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tile }
    end
  end

  # GET /tiles/1/edit
  def edit
    @tile = Tile.find(params[:id])
  end

  # POST /tiles
  # POST /tiles.json
  def create
    @tile = Tile.new(params[:tile])

    respond_to do |format|
      if @tile.save
        format.html { redirect_to @tile, notice: 'Tile was successfully created.' }
        format.json { render json: @tile, status: :created, location: @tile }
      else
        format.html { render action: "new" }
        format.json { render json: @tile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tiles/1
  # PUT /tiles/1.json
  def update
    @tile = Tile.find(params[:id])

    respond_to do |format|
      if @tile.update_attributes(params[:tile])
        format.html { redirect_to @tile, notice: 'Tile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiles/1
  # DELETE /tiles/1.json
  def destroy
    @tile = Tile.find(params[:id])
    @tile.destroy

    respond_to do |format|
      format.html { redirect_to tiles_url }
      format.json { head :no_content }
    end
  end
end
