Content-Type: multipart/mixed; boundary="===============7853604596829276945=="
MIME-Version: 1.0
From: David Ashley <dashxdr@gmail.com>
Subject: ofono with sim5320 module
Date: Mon, 07 Mar 2016 16:33:35 -0600
Message-ID: <CABkE59DVsbx1igJvM1zTtu4t2Fken=RiDQQchLwyJhXG9BzT+w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7853604596829276945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello, I'm at my wits' end trying to get ofono working with the
sim5320 module. I'm using the plugins/sim900.c module as a starting
point. I think the issue has something to do with the difference
between the MUX functionality between the 900 and the 5320. The sim900
supports the elaborate parameters sent on the
AT+CMUX=3D0,x,x,x,x, etc.
but the SIM5320 only supports
AT+CMUX=3D0

There's that... but also the way the sim900 plugin creates a
SETUP_DLC, initiates muxing, then deletes the setup DLC and creates 4
new DLC's... it didn't work for the sim5320 until I remapped the DLC's
somewhat like this:

#define NUM_DLC 4
#define VOICE_DLC   2
#define NETREG_DLC  1
//#define SMS_DLC     2
#define GPRS_DLC    3
#define SETUP_DLC   0

static char *dlc_prefixes[NUM_DLC] =3D {
 [VOICE_DLC]=3D"Voice: ",
 [NETREG_DLC]=3D"Net: ",
// [SMS_DLC]=3D "SMS: ",
 [GPRS_DLC]=3D "GPRS: " ,
 [SETUP_DLC]=3D "Setup: ",
};

Note I have to eliminate the SMS_DLC usage later in sim5320_post_sim:
//	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
//						data->dlcs[SMS_DLC]);


OK everything is *ALMOST* working. ofonod interacts fine with
connmand, connmand tells ofonod to activate the sim5320, which
actually establishes a ppp connection and sets up a ppp device:
ppp0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-=
00-0
          inet addr:30.97.132.47  P-t-P:30.97.132.47  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:500
          RX bytes:0 (0.0 B)  TX bytes:124 (124.0 B)


Here's the rub: No matter what I do, I never get any RX packets from
that ppp device, and even when it appears to TX packets (I'm trying to
ping out) the machine on the internet isn't actually receiving them.

I'm running on a beaglebone with a custom board with a sim5320 module on it.

I have no idea what to try...  Any advice would be appreciated...
Thanks very much!!!!
-Dave

--===============7853604596829276945==--

