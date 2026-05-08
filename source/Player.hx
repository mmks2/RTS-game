import sys.net.Socket;
import sys.net.Host;
import haxe.io.BytesBuffer;
class Player {
	public var socket:Socket;
	public var money=600;
	public var buffer:BytesBuffer;
	public var myid = -1;
	public function new (socket:Socket) {
		this.socket=socket;
		this.buffer = new BytesBuffer();
	}
	public function update_balance() {
		this.writeInt(Ids.MONEY);
		this.flush();
		this.money=readIntBlock();
	}
	public function get_id() {
		this.writeInt(Ids.ID);
		this.flush();
		this.myid=readIntBlock();
	}
	public function writeInt(int:Int) {
		var bytes = haxe.io.Bytes.alloc(4);
		bytes.setInt32(0,int);
		buffer.addBytes(bytes,0,4);
	}
	public function readIntBlock():Int {
		while (true) {
			try {
				return socket.input.readInt32();
			} catch (e:Dynamic){
			
			}
		}
	}
	public function readInt():Int {
		try {
			return socket.input.readInt32();
		} catch (e:Dynamic){
			return -1;
		}
	}
	public function flush() {
		var data = this.buffer.getBytes();
		socket.output.writeBytes(data,0,data.length);
		this.buffer = new BytesBuffer();
	}
	public function writeString(string:String) {
		var bytes = haxe.io.Bytes.ofString(string);
		buffer.addBytes(bytes,0,bytes.length);
	}
}