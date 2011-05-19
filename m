Content-Type: multipart/mixed; boundary="===============8256152933289403201=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: Emulator not unregistered while sending ATH0
Date: Thu, 19 May 2011 14:12:47 +0200
Message-ID: <4DD5093F.6050307@linux.intel.com>
In-Reply-To: <4DD4ED45.3050907@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8256152933289403201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I have mixed some stuff concerning GIOChannels...

On 19/05/2011 12:13, Guillaume Zajac wrote:
> Hi Denis,
>
> I noticed that when I send +++ -> ATH0 during a PPP session the ppp =

> server is well unregistered.
> However when the physical layer is removed (bluetooht or TCP), the =

> associated emulator is not unregistered.
> As we used in gatutil.c set_close_on_unref(TRUE), it means there is =

> still on reference on the GIOChannel.

The set_close_on_unref() from gatutil.c is done for ppp_net interface =

GIOChannel.
It has nothing to do with the physical layer.

However, we do also:
     - set_close_on_unref(TRUE) into example/emulator.c
     - set_close_on_unref(FALSE) into plugins/dun_gw.c

So after the client send ATH0, the connection is removed and emulator =

should be unregistered and removed but it is not the case.

> In the case the PPP session is ended normally, we call =

> ppp_ipcp_down_notify() to free the ppp_net interface.
> Then the physical layer is removed and we got the emulator well =

> unregistered.

That's why I assume unregistration of the emulator is bound to the way =

PPP session is ended e.g.
normally ---> ppp_ipcpdown_notify()
forced ---> ATH0

> Do you have any idea about what is happening there?
> Maybe I forgot to do something into dun_ath_cb().

Kind regards,
Guillaume

--===============8256152933289403201==--

