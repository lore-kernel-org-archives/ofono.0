Content-Type: multipart/mixed; boundary="===============6322996716299768349=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [info] modem data disconnection
Date: Tue, 21 Jul 2015 10:03:49 -0500
Message-ID: <55AE5F55.9080001@gmail.com>
In-Reply-To: <55AE2D9E.6080106@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6322996716299768349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mylene,

On 07/21/2015 06:31 AM, Mylene JOSSERAND wrote:
> Hi everyone,
>
>
> I have some questions about ofono and the data disconnection.
>
> With debug information, after that my modem is online (connected to netwo=
rk via ppp0 interface), when I go back to offline (by setting online proper=
ty to false), I can see that the modem network connection is down with :
> ofonod[1039]: Modem: < ~\377}#\300!}%}#} }$\205r~
>
> and PPP interface is removed :
> ofonod[1039]: udevng.c:remove_device() /sys/devices/virtual/net/ppp0
>
> I searched how ofono stops the modem connection, with escape sequence for=
 example, but ofono does not seem to use it during offline sequence.
>

In this case the ofono_gprs_context atom is being created in post_online =

state.  Since you go offline, the modem goes back to post_sim state and =

any atoms created in post_online() are destroyed.  E.g. the atom's =

remove() method is called.  This removes all PPP processing from the =

chat and forces it back into AT command mode.

There was a similar thread recently about SIM Removal on HE910 =

exhibiting similar behavior.  In that case the modem went back to =

pre_sim state, so all post_sim and post_online atoms were destroyed.

> How does ofono handles it ?

Solution is to put gprs_context creation into pre_sim on modems that =

reply to CFUN=3D4 or equivalent before sending the final PPP frame.

> How ofono (or gatppp, maybe ?) puts the modem network connection down (if=
 it does) ?
>

oFono detects PPP end-of-session frames as well as the NO CARRIER result =

code.  See gatchat/gathdlc.c new_bytes() and =

g_at_hdlc_set_no_carrier_detect()

Regards,
-Denis

--===============6322996716299768349==--

