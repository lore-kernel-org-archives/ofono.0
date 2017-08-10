Content-Type: multipart/mixed; boundary="===============1139335817345608939=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: SIM not starting up reliably on rilmodem
Date: Thu, 10 Aug 2017 16:58:24 -0600
Message-ID: <70053b34-a661-1922-8e1c-7ff62072d515@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1139335817345608939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm running oFono with the rilmodem driver on an MSM8930AB-based phone =

(Samsung GS4 Mini GT-I9195). I'm having issues getting it to come online =

reliably. oFono can always connect to rild and get device identifiers =

etc., but often when I set the modem property Online to true, it doesn't =

come all the way up. It will report being Online, and rild sends some =

things like signal strength updates, but most of the interfaces and =

properties oFono offers aren't available in this state (e.g., SimManager =

reports SIM not Present.) When it happens I kill ofonod and try again =

until it works. It's pretty easy to spot, because a successful =

connection causes a flurry of SIM I/O calls. I haven't used it =

extensively yet, but network state, SMS, and calls are working in my tests.

Here are a couple of snippets from logs at different times:

E/RILD    (30928): radioState(0) so did not update simState

E/RILD    ( 3655): SetSimOperator: invalid operator
E/RILD    ( 3655): OnRadioStateChanged: sim operator not ready wait for read

ofonod[19106]: [0,0014]< RIL_REQUEST_SET_PREFERRED_NETWORK_TYPE failed =

RADIO_NOT_AVAILABLE
E/RILD    (19068): Blocked preferred net type(1) due to sim state(0)

It's almost as if there is a circular dependency between the SIM and the =

radio state, that resolves itself if the timing comes out right. I can =

give more detailed logs if something specific would be helpful.

 From comparing some logs and making some guesses, I arrived at a hack =

of sending RIL_REQUEST_SCREEN_STATE =3D TRUE as part of the rild =

connection initialization, and sending TRUE again later in =

ril_radio_settings_probe(). This makes the startup more likely to =

succeed, but still not perfect (it changed from taking 10-20 tries to =

something like five.) I don't know if one of these changes is more =

effective than the other, but it's good enough for now.

So, has anyone else seen this kind of thing, or have ideas on how to =

make it more reliable? Also, what is the state of the rilmodem fork@=

https://github.com/rilmodem/ofono ? I'm using the mainline oFono code =

right now.

Thanks,
Joey Hewitt

--===============1139335817345608939==--

