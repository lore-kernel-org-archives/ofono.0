Content-Type: multipart/mixed; boundary="===============0590319621455433122=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] cdma-connman: Add cdma-netreg status watch to
 activate data call
Date: Sun, 30 Oct 2011 03:27:09 -0500
Message-ID: <4EAD0A5D.80008@gmail.com>
In-Reply-To: <4EAEBE5F.7080208@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0590319621455433122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> There is no concept of attachment in CDMA, so I'd prefer we not do it
>> this way.  Can't we simply check the current netreg atom status here?
> =

> Fine for me. Then we should also create a new D-Bus error message like:
> __ofono_error_not_registered().
> =


That sounds fine to me.

<snip>

>> It seems to me that this is way too complicated.  All you want is to
>> check the netreg status before trying to set powered.  If we lose netreg
>> when the connection is active, then the regular cdma-connman
>> notification procedures would apply.
> =

> Once we lost netreg, what are we supposed to do?
> cdma-netreg atom will signal "Status" property has changed.
> Is that up to ConnMan to deactivate the data call in checking the
> cdma-netreg "Status" property equal to "unregistered"?

Ah, so that's what you want to accomplish.  This wasn't clear from your
patch.  You have two options here:

- Rely on the modem to drop the data connection and have the
cdma-connman driver notify us appropriately.  The mechanism would be
similar to ofono_gprs_context_deactivated.

- In addition to above, force the Powered property to False when the
registration is lost.  In which case you would need the status watches.

Regards,
-Denis

--===============0590319621455433122==--

