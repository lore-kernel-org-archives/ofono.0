Content-Type: multipart/mixed; boundary="===============6616326707643631183=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Query on ppp0 interface for HE910 device
Date: Fri, 29 May 2015 19:45:46 -0500
Message-ID: <5569083A.9060408@gmail.com>
In-Reply-To: <CANPyyuOxuvE8dxOQR8+CQJRzXek291_3GuDsNhPAf2ONFccU3Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6616326707643631183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On 05/29/2015 12:24 PM, Mike Williams wrote:
>> Whenever the connman daemon switches from cellular to wifi automatically=
, ofonod >removes the ppp0 interface.
>> On the oterhway round the ofono daemon is not doing the addition of the =
ppp0 interface.
>
> I can reproduce this on an HE910 I just started testing. Basically,
> the ofono cellular service never reappears to connman after connman
> disconnects it.
>
> # connmanctl technologies
> /net/connman/technology/cellular
>   Name =3D Cellular
>   Type =3D cellular
>   Powered =3D True
>   Connected =3D False
>   Tethering =3D False
> /net/connman/technology/ethernet
>   Name =3D Wired
>   Type =3D ethernet
>   Powered =3D True
>   Connected =3D False
>   Tethering =3D False
> # connmanctl services
> *AR Wired                ethernet_001122edb058_cable
> *A  T-Mobile             cellular_310260008772362_context1
> # connmanctl disable ethernet
> Disabled ethernet
> # macb f0028000.ethernet eth0: link down
> # connmanctl services
> *AR T-Mobile             cellular_310260008772362_context1
> # connmanctl enable ethernet
> IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> Enabled ethernet
> # macb f0028000.ethernet eth0: link up (100/Full)
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> # connmanctl services
> *AR Wired                ethernet_001122edb058_cable
> #

I don't know what connman is doing, but this sequence should not cause =

the GPRS state to be detached...  What does ConnMan actually call on the =

oFono side to get to this state?

>
> The cellular service will never reappear.
>
> ofono debug log:
>
> ofonod[1543]: PPP: lcp: pppcp_process_terminate_ack: current state 4:CLOS=
ING
> ofonod[1543]: PPP: lcp: pppcp_generate_event: current state 4:CLOSING
> ofonod[1543]: PPP: event: 11 (RTA), action: 802, new_state: 2 (CLOSED)
> ofonod[1543]: PPP: lcp: pppcp_this_layer_finished: current state 2:CLOSED
> ofonod[1543]: PPP: gatchat/gatppp.c:ppp_enter_phase() 0
> ofonod[1543]: PPP: gatchat/gatppp.c:ppp_dead()
> ofonod[1543]: drivers/atmodem/gprs-context.c:ppp_disconnect() Reason: 6
> ofonod[1543]: Aux: < \r\n+CGEV: ME DEACT IP, "22.226.202.227", 1\r\n
> ofonod[1543]: Aux: < \r\n
> ofonod[1543]: Aux: < +CGREG: 0\r\n\r\n+CGEV: NW DETACH\r\n

So the modem reports a network detach and loss of packet switched =

connection.  No context activations are possible@this point.  How are =

you triggering this?

Regards,
-Denis


--===============6616326707643631183==--

