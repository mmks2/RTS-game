import sys.net.Socket;
import sys.net.Host;
import Player;
import Ids;
#if !server
import hxd.App;
#end

#if server
class Main {
#else
class Main extends App {
#end
	#if server
	public function new() {
		var serv = new Socket();
		serv.bind(new Host("0.0.0.0"),8080);
		serv.listen(8);
		var players:Array<Player> = [];
		var player:Player;
		while (true) {
			if (players.length < 2) {
				player = new Player(serv.accept());
				player.money=600;
				player.myid = players.length;
				players.push(player);			
			}
			else {
				for (player in players.copy()) {
					var tp = player.readInt();
					if (tp == Ids.MONEY) {
						player.writeInt(player.money);
						player.flush();
					}
					else if (tp == Ids.ID){
						player.writeInt(player.myid);
						player.flush();
					}
				}
			}
		}
	}
	#end
	#if !server
	override public function init() {
		var socket = new Socket();
		socket.connect(new Host("127.0.0.1"),8080);
		socket.setBlocking(false);
		var player = new Player(socket);
		player.get_id();
		trace(player.myid);
		trace(player.money);
		while (true) {
			player.update_balance();
		}
	}
	#end
	static public function main():Void {
		new Main();
	}
}