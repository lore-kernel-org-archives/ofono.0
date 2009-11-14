Content-Type: multipart/mixed; boundary="===============3884032438521591358=="
MIME-Version: 1.0
From: Chris Pitchford <ofono@intrepid.cx>
Subject: Re: ppp
Date: Sat, 14 Nov 2009 19:26:38 +0000
Message-ID: <alpine.LNX.2.00.0911141915280.13597@boatman.intrepnet>
In-Reply-To: <fb249edb0911141050m6432fe81qa492ceb8f7c1ae61@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3884032438521591358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> Hi,
>
> 2009/11/13 Chris Pitchford <ofono@intrepid.cx>:
>> Is the line discipline so much of an issue when using ppp connected to a
>> fake tty? could that not be handed on the proxy side inside ofono?
>
> I've not tried it on a non-tty but it definitely should work modulo
> potential bugs that need to be squashed.  It's supposed to work.
>
> However by using a separate process to do ppp you add overhead.  The
> original idea in ofono as well as in other projects (think OpenMoko)
> was to have both ppp and multiplexing in the kernel to avoid the
> context switches when a lot of data is being sent, but this is not
> very portable and causes lots of other problems.  Having both in a
> single non-kernel process is going to be almost as fast and much more
> portable at the expense of reimplementing part of pppd.
>

I've had another thought.. and it doesn't push for pppd, but it introduces =

another idea.

When connecting to an APN for MMS services, there is the possibility of a =

clash of IP addresses both with other APN connections and with other =

internet connections (for example wifi)..


For example: wlan0 192.168.1.20/24 default gw 192.168.1.250

ppp0/tun0: 10.1.1.1 <=3D> 10.255.255.255

and the MMSC (to which the phone will need to communicate to send/receive =

MMS) is 192.168.1.20

bam.. it clashes with a locally assigned IP address and therefore no =

policy routing will allow a process to reach 192.168.1.20 via the MMS =

interface (or atleast not with excessive engineering)

Other clashes may cause problems too..

To solve the problem, the MMS environment could be run in its own kernel =

network name space. This means the ppp/tun interface would be separate =

from the other interfaces.. this removes the clashing IP address space =

problem.

If pppd were used, it could be "wrapped" in a different address space =

meaning the ppp interface would be localised to an environment that =

carried out all of the MMS communications. What's more, the work would =

require no change to the existing global address space.. it very neatly =

keeps the main environment seperate from the MMS environment that requires =

its own gateway and IP address space..

I appreciate the chances of a clash are slim, but with telcos using =

RFC-1918 and home users mainly using the same the chances of a clash are =

far above zero (and I hear it is a problem for iphone users.. no dig at =

iphones but a colleage reports seeing MMS traffic over his wireless =

connection.. not confirmed but still)

So, if ofonod is responsible for creating tun interfaces, I'm not sure it =

would be possible to isolate them within their own name space and =

therefore allow concurrent "internet" and "mms" access via two different =

connections..

I'm still formulating my thoughts on this one, but I hope it is food for =

thought!

cp

--===============3884032438521591358==--

