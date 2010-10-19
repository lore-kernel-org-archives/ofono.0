Content-Type: multipart/mixed; boundary="===============4704743674423454710=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: ISI crash when disconnecting N900 from USB
Date: Tue, 19 Oct 2010 11:29:56 +0300
Message-ID: <1287476996.30781.68.camel@tucson>
In-Reply-To: <1286942752.3425.2.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4704743674423454710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-10-13 at 06:05 +0200, ext Marcel Holtmann wrote:
> -------- backtrace --------
> [0]: isi_registration_status() [network-registration.c:271]
> [1]: set_auto_resp_cb() [network-registration.c:535]
> [2]: g_isi_cleanup_req() [client.c:241]
> [3]: g_isi_client_destroy() [client.c:310]
> [4]: isi_netreg_remove() [network-registration.c:974]
> [5]: netreg_remove() [network.c:1724]
> [6]: flush_atoms() [modem.c:350]
> [7]: ofono_modem_set_powered() [modem.c:794]
> [8]: report_powered() [isigen.c:77]
> [9]: g_pn_nl_link() [netlink.c:203]
> [10]: main() [main.c:240]
> [11]: _start() [audio-settings.c:0]

It looks like there was an ongoing registration attempt when you
disconnected the USB cable. The isimodem driver cleans up that pending
registration request, and in doing so, calls the atom's registration
callback indicating a failure.

However, in that callback, the netreg atom makes a new query for current
registration state, and that is what is crashing the isimodem driver.
The driver shouldn't try to initiate any more ISI requests, as it is in
the process of being removed.

I'll push a fix shortly.

Cheers,
Aki


--===============4704743674423454710==--

