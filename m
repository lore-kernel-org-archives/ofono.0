Content-Type: multipart/mixed; boundary="===============8449934024662177024=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/4] modem: add EmergencyMode property
Date: Wed, 08 Dec 2010 04:55:21 -0600
Message-ID: <4CFF6419.3090402@gmail.com>
In-Reply-To: <AANLkTinLasRE-FfDkRqwFFW5fpCedKVh2iiuzy1BwyDz@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8449934024662177024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>> So my only major concern left is here actually.  If we activate an
>> emergency call and a set_property(Online, blah) is active, we get into
>> some funny race conditions.  I mentioned these to Pekka on IRC.  But
>> basically the worst one is if we have an Online=3DFalse operation pendin=
g.
>>  In this case your call proceeds, but then gets terminated shortly
>> thereafter by the offline procedure ;)
> =

> That is a tricky problem. I'd say the most straightforward way is to
> return an error if there is a pending operation and push these
> problems up the stack. In any case dialer has to retry ecall if user
> tries to make the emergency call just after or before moving device to
> offline / removing SIM card / etc. However, I'm not sure if we can
> propagate the error in all cases where ofono_modem_inc_emergency()
> gets called.

There's really no way for the voicecall atom to know that a modem is
undergoing an online / offline transition..

> =

> In order to manage the worst case in best possible manner, I'd check
> for set_online in progress here. Return FALSE from
> ofono_modem_get_online() immediately after the set_online(FALSE) call
> is made. Also, check the emergency state again in after set_online
> callback response. The online/offline watches should be called before
> the set_online() call. (I have no idea what we will do should
> set_online(FALSE) fail)?
> =


So my thinking was essentially along the same lines.  We can check
whether an Online change operation is in progress by peeking at the
pending D-Bus message.  If we're going online, then not triggering
another set_online call and waiting for the online_cb should be sufficient.

If we're going offline, then returning FALSE from ofono_modem_get_online
and re-checking the emergency counter in the offline_cb seems like the
way to go.

I'd like to take care of this completely inside oFono and not bother the
dialer with these details.  Thoughts?

Regards,
-Denis


--===============8449934024662177024==--

