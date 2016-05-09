Content-Type: multipart/mixed; boundary="===============6466541131718250215=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT channel problem
Date: Mon, 09 May 2016 09:19:28 -0500
Message-ID: <57309C70.2060005@gmail.com>
In-Reply-To: <CAH4ZQwu20Jxfrgr51L6UP1eraH+mi_VK-8NCiq3KA4J+89soRw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6466541131718250215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 05/09/2016 02:43 AM, Enrico Sau wrote:
> ofonod[1306]: Aux: < #QSS: 0\r\n
> ofonod[1306]: 09:33:54|plugins/he910.c[173]:he910_qss_notify() 0x88ef560
> ofonod[1306]: 09:33:54|plugins/he910.c[131]:switch_sim_state_status() 0x8=
8ef560, SIM status: 0
> ofonod[1306]: 09:33:57|src/modem.c[496]:modem_change_state() old state: 3=
, new state: 1
> ofonod[1306]: 09:33:57|src/modem.c[409]:flush_atoms()
> ofonod[1306]: 09:34:04|src/gprs.c[2279]:gprs_context_unregister() 0x88eef=
68, 0x88ee908
> ofonod[1306]: 09:34:04|src/gprs.c[2413]:gprs_context_remove() atom: 0x88e=
ef88
> ofonod[1306]: 09:33:42|drivers/atmodem/gprs-context.c[420]:at_gprs_contex=
t_remove()
> ofonod[1306]: 09:34:04|src/gprs.c[2644]:gprs_unregister() 0x88ee908
> ofonod[1306]: 09:33:58|src/network.c[1173]:__ofono_netreg_remove_status_w=
atch() 0x88eb2d0
> ofonod[1306]: 09:34:04|src/gprs.c[2683]:gprs_remove() atom: 0x88ee970
> ofonod[1306]: 09:34:02|src/sim.c[2714]:ofono_sim_remove_spn_watch() 0x88e=
d6f0
> ofonod[1306]: 09:33:58|src/network.c[1836]:netreg_remove() atom: 0x88eb338
> ofonod[1306]: 09:34:09|src/telit-data-network.c[323]:telit_data_network_r=
emove() atom: 0x88eb1c8
> ofonod[1306]: 09:34:09|src/telit-urc.c[668]:telit_urc_remove() atom: 0x88=
eb0a8
> ofonod[1306]: 09:34:05|src/radio-settings.c[657]:radio_settings_remove() =
atom: 0x88ee578
> ofonod[1306]: 09:33:28|plugins/udevng.c[1009]:remove_device() /sys/device=
s/virtual/net/ppp0
> ofonod[1306]: Aux: < \r\n
> ofonod[1306]: Aux: < +CGEV: NW DEACT IP, "2.194.193.31", 1\r\n
> ofonod[1306]: Modem: < ~\377}#\300!}%}"} }$Y(~

Now I get what is happening.  You're on a PPP link and pull the SIM.  So =

oFono tears everything down, but this results in the GAtChat going from =

PPP mode to normal mode too early.

We then receive the final HDLC frame, and that confuses the syntax. =

GSMv1 syntax already has code to handle this, but looks like the =

permissive one doesn't.

> ofonod[1306]: Modem: < \r\nNO CARRIER\r\n
> ofonod[1306]: Modem: < \r\n
> ofonod[1306]: Aux: < \r\n

Regards,
-Denis

--===============6466541131718250215==--

