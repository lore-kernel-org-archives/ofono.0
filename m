Content-Type: multipart/mixed; boundary="===============8176170084022491193=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono plugin and state transmissions
Date: Sat, 12 Mar 2016 09:38:55 -0600
Message-ID: <56E4380F.4040904@gmail.com>
In-Reply-To: <loom.20160312T144416-707@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8176170084022491193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

On 03/12/2016 07:57 AM, Holger Freyther wrote:
> Hi,
>
> at sysmocom we are building a BTS (OsmoBTS, OpenBSC) test setup and
> use ofono to build our testcases. We are using Sierra Wireless (former
> Wavecom) modules and have some stability issues.
>
> I have two issues that I don't understand and they are related to the plu=
gin
> model and after looking at others I don't find the answer.
>
> In the beginning we used the +WIND indication and created objects. E.g.
> we created the netreg after it starts to search for networks.. but if the
> +WIND indication fro the SIM ready came either during the registration
> or before.. we would see crashes. We now mostly ignore +WIND and guess
> about it. Not all plugins create all objects and they are created at diff=
erent
> points. So what is the best way to do it?

I'm not familiar with the WIND indication.  Can you provide a reference =

to documentation?

In general, all atoms should be created in pre_sim(), post_sim() or =

post_online() callbacks.

>
> One other problem is that post_sim doesn't seem to be called. After looki=
ng
> at the src/modem.c file I see that it is only called for certain states. =
E.g.
> it looks like it is only called if the modem is still in the offline stat=
e and
> appears to be never called for us. Is there a way to debug it? E.g. when =
should
> the modem be powered up? when the SIM has been read? When the AT command
> interpreter is ready?

pre_sim() is called as soon as the modem is powered.

post_sim() is called as soon as we detect that the SIM PIN has been =

entered.  E.g. via org.ofono.SimManager.EnterPin or if the PIN is not =

locked.  If certain SIM operations are simply not available, we assume =

the SIM is not locked.  It is generally not called more than once, =

unless you remove the SIM (e.g. hot-swap capability).

post_online() is called when .set_online(TRUE) is executed successfully.

In general oFono expects that after calling the .set_powered(TRUE) =

driver method, the modem is brought up to the point where it can accept =

AT commands and the SIM Card reader is enabled.  oFono can then get =

basic info from the modem.  After the SIM Card reader detects the SIM =

and the modem is ready to accept SIM related operations, the modem =

driver should call ofono_sim_inserted_notify(TRUE);

So basically:
AT interpreter ready, SIM Card Powered -> Powered =3D True, Online =3D False
Above + Radio RX/TX circuits on -> Powered =3D True, Online =3D True

Complete debugging instructions can be found in ofono.git/HACKING.  I =

presume the Sierra modem is AT command based, so:

export OFONO_AT_DEBUG=3D1
src/ofonod -n -d

>
>
> kind regards
>    holger

Regards,
-Denis


--===============8176170084022491193==--

