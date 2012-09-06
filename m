Content-Type: multipart/mixed; boundary="===============6953740020338771354=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: context activation quickly after context deactivation fails
Date: Thu, 06 Sep 2012 10:13:15 -0500
Message-ID: <5048BD8B.6070103@gmail.com>
In-Reply-To: <CABvLYuCBtJeCqGE1-iryBj44Owcv5KDct5bDFKFpP0UZRcHL2w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6953740020338771354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 09/06/2012 09:09 AM, Cedric Jehasse wrote:
> Hi Denis,
>
> with the patch i don't get a reply when deactivating the context. From
> the on it's not possible to activate the context, because the
> operation is still in progress.
> This is a log of the deactivation:
>
> Jan  1 03:13:05 ofonod[6856]:
> drivers/atmodem/gprs-context.c:at_gprs_deactivate_primary() cid 1
> Jan  1 03:13:05 ofonod[6856]: PPP: lcp: pppcp_generate_event: current
> state 9:OPENED
> Jan  1 03:13:05 ofonod[6856]: PPP: event: 3 (Close), action: 8224,
> new_state: 4 (CLOSING)
> Jan  1 03:13:05 ofonod[6856]: PPP: lcp:
> pppcp_initialize_restart_count: current state 9:OPENED
> Jan  1 03:13:05 ofonod[6856]: PPP: lcp: pppcp_send_terminate_request:
> current state 9:OPENED
> Jan  1 03:13:05 ofonod[6856]: PPP: ipcp: pppcp_generate_event: current
> state 9:OPENED
> Jan  1 03:13:05 ofonod[6856]: PPP: event: 1 (Down), action: 201,
> new_state: 1 (STARTING)
> Jan  1 03:13:05 ofonod[6856]: PPP: gatchat/gatppp.c:ppp_enter_phase() 5
> Jan  1 03:13:07 ofonod[6856]: PCUI:<  \r\n^MODE:5,4\r\n
> Jan  1 03:13:07 ofonod[6856]: Modem:<  \r\nNO CARRIER\r\n
> Jan  1 03:13:08 ofonod[6856]: PCUI:<  \r\n^RSSI:18\r\n
> Jan  1 03:13:11 ofonod[6856]: PCUI:<  \r\n^RSSI:18\r\n

Looks like I got the chat instances mixed up since the NO CARRIER is not =

being picked up.

Can you change:
+       g_at_chat_register(chat, "NO CARRIER", no_carrier_notify,
+                               FALSE, gc, NULL);

to read:

+       g_at_chat_register(gcd->chat, "NO CARRIER", no_carrier_notify,
+                               FALSE, gc, NULL);

Regards,
-Denis

--===============6953740020338771354==--

