Content-Type: multipart/mixed; boundary="===============2665003690552862131=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: atmodem: gprs context deactivate crashes ofonod
Date: Thu, 20 May 2010 09:49:27 +0300
Message-ID: <87632j6pag.fsf@potku.valot.fi>
In-Reply-To: <201005190902.44297.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2665003690552862131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi Denis,

>> I have been testing ofono with my Huawei E1552 usb stick, which is using
>> atmodem and PPP. I noticed that whenever I call test/deactivate-context
>> ofono either crashes or busyloops here in at_gprs_deactivate_primary():
>> =

>> 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
>> 				at_cgact_down_cb, cbd, g_free) > 0)
>> 		return;
>> =

>> Further investigation revealed that gcd->chat is already unreferenced in
>> setup_ppp():
>> =

>> 	g_at_chat_unref(gcd->chat);
>> =

>> So there's a conflict here. How to handle this properly? Calling
>> g_at_ppp_shutdown() is most likely not enough, because nobody is not
>> creating gcd->chat again which is needed during subsequent activate
>> call.
>> =

>> Comments?
>> =

>
> Deactivation of the context was never made to work properly. For a
> hint, please have a look at gatchat/gsmdial.c. When PPP is established
> we should be using g_at_chat_suspend. During a context deactivation we
> should use g_at_ppp_shutdown and then reactivate the gatchat using
> g_at_chat_resume

Ok, thank you for the tips. I'll take a look at this later, I have to
fix some other issues first.

> (assuming the Huawei does not HUP the tty when disconnecting the ppp
> link.)

Let's hope not.

-- =

Kalle Valo

--===============2665003690552862131==--

