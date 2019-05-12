require 'rss'
require 'open-uri'

class CastController < ApplicationController
   
   
    def index
        if session[:user_id]
            @feeds = Feed.all
        else
            redirect_to login_path
        end
    end

    def create

        url = params.require(:url)
        begin
            if !verify_duplicate(url)
                feed = Feed.new get_feed_info(url)
                if feed.save
                    flash[:notice] = "Produto Salvo com Sucesso"
                end
            else 
                flash[:notice] = "Produto já existente"
            end
            redirect_to cast_index_path
        rescue
            redirect_to cast_index_path, notice: "Link não suportado"
        end
    end

     def show
        if !session[:user_id]
            redirect_to login_path
        else
             @list = []
            query = Feed.find_by id: params[:id]
            feed_rss = RSS::Parser.parse(query.url)
            epsodes =  feed_rss.items
        
            @cover = query.path_cover
            epsodes.each do |ep|
                @list << { "title" => ep.title, 
                        "url" =>  ep.enclosure.url, 
                        "descricao" => ep.description 
                        }
            end
        end
    end

    def destroy

        feed = Feed.find(params[:id])
        feed.destroy
        redirect_to cast_index_path
    end

    private

    def get_feed_info(url)
   
        open(url) do |rss|
            feed_rss = RSS::Parser.parse(rss)
            title = feed_rss.channel.title
            path_cover = feed_rss.channel.image.url
            
            { "name" => title, "url" => url, "path_cover" => path_cover }
            end
    end

    def verify_duplicate(url)
        Feed.find_by url: url
    end

end
