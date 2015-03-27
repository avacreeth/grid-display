class TilesController < ApplicationController
  # GET /tiles
  # GET /tiles.json
  def index
    @tiles = Tile.for_grid(params[:grid_id]).order(:position).all
    @grid_id = params[:grid_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json do
        plan = GridPlanner.new(8, 5).plan(@tiles.first(12))

        puts @tiles.inspect
        puts plan.inspect

        to_render = plan.grid[:tiles].map do |p_tile|
          tile = Tile.find(p_tile.id)

          {
            id: tile.id,
            content: tile.content,
            type: tile.content_type,
            sizex: p_tile.sizex,
            sizey: p_tile.sizey,
            posx: p_tile.posx,
            posy: p_tile.posy,
            rel_size: p_tile.size
          }
        end

        render json: to_render
      end
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
    @grid_id = params[:grid_id]

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
        @tile.move_to_top
        format.html { redirect_to grid_tiles_path(params[:grid_id]), notice: 'Tile was successfully created.' }
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

    puts params.inspect

    if params[:awesome]
      @tile.move_to_top
    elsif params[:lame]
      @tile.move_to_bottom
    end

    respond_to do |format|
      if @tile.update_attributes(params[:tile])
        format.html { redirect_to grid_tiles_path(@tile.grid_id), notice: 'Tile was successfully updated.' }
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
      format.html { redirect_to grid_tiles_url(@tile.grid_id) }
      format.json { head :no_content }
    end
  end
end
