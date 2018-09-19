Content-Type: multipart/mixed; boundary="===============1654534975381732252=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 1/3] sim800: adding support for Simcom SIM800 modem
Date: Wed, 19 Sep 2018 21:52:05 +0200
Message-ID: <20180919195205.GC3536@turing>
In-Reply-To: <2048901537376607@iva4-031ea4da33a1.qloud-c.yandex.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1654534975381732252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, Sep 19, 2018 at 08:03:27PM +0300, Pi=C4=8Dugins Arsenijs wrote:
Hi,

I guess I submit it in a hurry and forgot to add the firmware version.
BTW, your problem may be related to this. Are you sure your CMUX command is=
 not returning an error ? Thus preventing ofono from enabling the modem ? I=
 had this problem and Simcom sent me an updated firmware that supports the =
CMUX command.

> <div>Hello!</div><div>=C2=A0</div><div>&gt; You might want to describe ho=
w this is different from sim900 that it<br />&gt; warrants a fully separate=
 driver?</div><div>=C2=A0</div><div>I've tried to apply this patch yesterda=
y evening (since I too am</div><div>interested in SIM800 integration) and t=
ried to apply it, patch 2</div><div>doesn't apply on current master for som=
e reason. Here's a diff</div><div>between current SIM900 and this SIM800:</=
div><div><a href=3D"https://matrix.org/_matrix/media/v1/download/matrix.org=
/KqDxbcuYLxrcceUfRorxYgus" data-external=3D"true">https://matrix.org/_matri=
x/media/v1/download/matrix.org/KqDxbcuYLxrcceUfRorxYgus</a></div><div>=C2=
=A0</div><div>tl;dr: apart from</div><div>=C2=A0</div><div>- adding phonebo=
ok support (two lines, I don't understand it quite yet)</div><div>- the sle=
ep() hack</div><div>- a comment clarifying a problem with some unknown vers=
ion of firmware</div><div>- DBG() log calls</div><div>- sim900 =3D&gt; sim8=
00 renaming</div><div>=C2=A0</div><div>it's no different than current SIM90=
0 driver. Unfortunately, that</div><div>doesn't solve the problems I'm pers=
onally experiencing (hang on</div><div>CFUN, for one).</div><div>=C2=A0</di=
v><div>Cheers!<br />Arsenijs</div><div>=C2=A0</div><div>19.09.2018, 19:51, =
"Denis Kenzior" &lt;denkenz(a)gmail.com&gt;:</div><blockquote type=3D"cite"=
><p>Hi,<br /><br />On 09/18/2018 03:36 PM, Cl=C3=A9mentViel wrote:</p><bloc=
kquote>=C2=A0From: clem &lt;<a data-external=3D"true" href=3D"mailto:vielcl=
ement@gmail.com">vielclement(a)gmail.com</a>&gt;<br />=C2=A0</blockquote>=
<p><br />You might want to describe how this is different from sim900 that =
it<br />warrants a fully separate driver?<br /><br />If there are only mino=
r differences, then this can be handled via UDEV<br />attributes or queryin=
g +CGMM, etc.<br />=C2=A0</p><blockquote>=C2=A0---<br />=C2=A0=C2=A0=C2=A0M=
akefile.am | 4 +<br />=C2=A0=C2=A0=C2=A0plugins/sim800.c | 424 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++<br />=C2=A0=C2=A0=C2=A02 files =
changed, 428 insertions(+)<br />=C2=A0=C2=A0=C2=A0create mode 100644 plugin=
s/sim800.c<br />=C2=A0</blockquote><p><br />&lt;snip&gt;<br />=C2=A0</p><bl=
ockquote>=C2=A0+<br />=C2=A0+static void sim800_post_sim(struct ofono_modem=
 *modem)<br />=C2=A0+{<br />=C2=A0+ struct sim800_data *data =3D ofono_mode=
m_get_data(modem);<br />=C2=A0+ struct ofono_gprs *gprs;<br />=C2=A0+ struc=
t ofono_gprs_context *gc;<br />=C2=A0+<br />=C2=A0+ DBG("%p", modem);<br />=
=C2=A0+<br />=C2=A0+ /* Dirty Hack : give some time to sim800 for multiplex=
ing<br />=C2=A0+ * to be effective and avoid VOICE_DLC to be<br />=C2=A0+ *=
 flooded thus leading to a "famine" situation<br />=C2=A0+ */<br />=C2=A0+<=
br />=C2=A0+ sleep(2);</blockquote><p><br />No sleeps inside plugins. That =
blocks the entire daemon and we can't<br />have that. How does this help yo=
u anyway? GAtChat is a queue, so only<br />1 command is outstanding at a ti=
me.<br />=C2=A0</p><blockquote>=C2=A0+ ofono_sms_create(modem, OFONO_VENDOR=
_SIMCOM, "atmodem",<br />=C2=A0+ data-&gt;dlcs[SMS_DLC]);<br />=C2=A0+<br /=
>=C2=A0+<br />=C2=A0+ gprs =3D ofono_gprs_create(modem, 0, "atmodem", data-=
&gt;dlcs[GPRS_DLC]);<br />=C2=A0+ if (gprs =3D=3D NULL)<br />=C2=A0+ return=
;<br />=C2=A0+<br />=C2=A0+ gc =3D ofono_gprs_context_create(modem, OFONO_V=
ENDOR_SIMCOM,<br />=C2=A0+ "atmodem", data-&gt;dlcs[GPRS_DLC]);<br />=C2=A0=
+ if (gc)<br />=C2=A0+ ofono_gprs_add_context(gprs, gc);<br />=C2=A0+}<br /=
>=C2=A0+</blockquote><p><br />Regards,<br />-Denis<br />___________________=
____________________________<br />ofono mailing list<br /><a data-external=
=3D"true" href=3D"mailto:ofono@ofono.org">ofono(a)ofono.org</a><br /><a h=
ref=3D"https://lists.ofono.org/mailman/listinfo/ofono">https://lists.ofono.=
org/mailman/listinfo/ofono</a></p></blockquote>

--===============1654534975381732252==--

