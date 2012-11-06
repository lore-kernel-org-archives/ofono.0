Content-Type: multipart/mixed; boundary="===============6639839670564199550=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono bug
Date: Tue, 06 Nov 2012 09:01:25 -0600
Message-ID: <50992645.9060604@gmail.com>
In-Reply-To: <22bf93ea.1c0c0.13ad61e5931.Coremail.wujiangbo_1987@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6639839670564199550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Just a gentle reminder not to top-post on this mailing list.

On 11/06/2012 08:27 AM, =E5=90=B4=E6=B1=9F=E6=B3=A2 wrote:
> Hi,
> i already fix the bug, so i think this is the real bug.
> i set a callback fuc to GAtMux, and add status member for echo channel,
> when i find the channel active, it will call back the fuc, fuc check all
> channel is active, if all channel is active, continue to send AT
> commands you want.
>
>

It is pretty hard to follow what you mean here.  Can you send the actual =

fix as a patch? e.g. git send-email

>
>
>
> At 2012-11-06 22:23:21,"=E5=90=B4=E6=B1=9F=E6=B3=A2" <wujiangbo_1987@16=
3.com> wrote:
>
>     Hi Denis Kenzior,
>     I find a bug about ofono, in src/ifx.c. The function
>     setup_internal_mux. if we modem use Mux in ofono code, ofono will
>     create six channel to send request. After we send AT commands, each
>     mux channel should be active that through send a little data and

To state this another way, we open the channel by sending the DLC =

establishment command.  This creates a mapping between that dlc number =

and a GIOChannel.

>     receive. In setup_internal_mux function it only set 10 millisecond
>     to do that, it manual think channel active while 10 millisecond. if
>     the modem don't response channel active in 10 millisecond, the

The T1 we negotiated during CMUX is 10ms, we assume that the channel =

establishment doesn't fail, however the timing might need to be relaxed =

a bit due to how long it might take the kernel to transmit.

>     sending AT commands don't dispatch to right channel. if you are

Sorry I don't follow this.  The sending will always dispatch to the =

right DLC since the DLC number is associated with the GIOChannel.

>     lucky, ofono will work well, but it don't guarantee. and also i have
>     the problem. ofono don't work well, it be cause by channel havn't
>     configure, ofono send AT comands. The GAtMux receive the response,
>     but GAtMux don't know which channel the response should be
>     dispatched. GAtMux will discard the right response, and the AT

Again, I don't follow.  The AT commands are coming on a particular DLC. =

  The DLC mapping is already established after g_at_mux_create_channel =

is called.

>     command will don't receive the response forever, it will case some
>     request timeout, and ofono think it have some problem it don't work.
>     any questions. then we open mux, ofono will create a new IOChannel,
>     the previously device IOChannel should remove from main context, but
>     ofono don't do that. why?

I don't understand the question, sorry.

Regards,
-Denis

--===============6639839670564199550==--

