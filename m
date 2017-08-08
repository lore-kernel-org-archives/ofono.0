Content-Type: multipart/mixed; boundary="===============8000391396269231094=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] add call-list helper to manage voice call lists
Date: Tue, 08 Aug 2017 08:33:09 -0500
Message-ID: <f83c9485-825d-f21e-9dde-395ddbb8d743@gmail.com>
In-Reply-To: <20170808142328.14bb9337@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8000391396269231094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

>> We are not exposing glib into the oFono plugin API.  So the use of
>> GSList, etc data structures across driver <-> core boundary is not
>> possible.  The reasons are somewhat historic, but essentially
>> non-GLib based plugins must be possible.  Also, oFono's use of GLib
>> will be replaced by ell [1] in the future.
> Interesting. Do you have any plans when and how the migratation will
> be done?
> =


No concrete timelines, but most likely we will simply introduce a =

dependency on ell at some point and start converting code over until all =

traces of GLib are eradicated.

>> I'm still not quite sure what you're trying to solve with these
>> changes? A bit more info on the motivation of the patches in the
>> commit description would be helpful...
> =

> My motivation is to get rid of the generic part in the
> modem drivers. E.g. look at the rild and atmodem, they have a lot
> similiar code when parsing the call list.
> =

> So it would be nice to replace those. On the other side I've written a
> voicecall driver for qmi which is using the call list, but I'm still
> testing it.
>

Okay, I see now.  In the ideal world the call state notification =

mechanism provides all the information needed so that a driver internal =

call list is not needed.  See calypsomodem/voicecall.c for example.

For drivers that do use a call list, maybe we can put the common code =

into drivers/common/*.[ch] or so.

Regards,
-Denis

--===============8000391396269231094==--

