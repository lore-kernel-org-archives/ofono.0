Content-Type: multipart/mixed; boundary="===============3038568214509067331=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 00/11] Add PPP server support
Date: Sat, 12 Jun 2010 13:50:39 +0800
Message-ID: <1276321850-13307-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3038568214509067331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The patches extend GAtPPP to support PPP server role, so that you use gsmdi=
al or wvdial to talk to test-server (Patch 6/11 adds PPP server support in =
test-server).

If you're interesting to try it, connect two machines by BlueZ serial proxy.

Server side:
1. Run ./test-server by 'root'. It will tell you the server port.
2. Update /etc/bluetooth/servial.conf. Create one if it doesn't exist.

	[Proxy DUN] # UUID for DUN proxy service
	UUID=3D00001103-0000-1000-8000-00805F9B34FB
	# Address for device node
	Address=3D/dev/pts/xxx

3. Restart bluetoothd.

Client side:
1. rfcomm bind -r <server bdaddr> 1
2. Run './gsmdial -n /dev/rfcomm0' by 'root'. =


You may update client's /etc/resolve.conf with server DNS info.



--===============3038568214509067331==--

