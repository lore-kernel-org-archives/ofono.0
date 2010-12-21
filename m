Content-Type: multipart/mixed; boundary="===============2665872216241365462=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Tue, 21 Dec 2010 21:34:09 +0000
Message-ID: <871v5aajzi.fsf@ossau.uklinux.net>
In-Reply-To: <4D110110.1070104@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2665872216241365462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Marcel,
>
>>> Then I didn't look far back enough (or I'm simply blind).  But I still
>>> prefer this to be inside the driver or HACKING.calypso for easier acces=
s.
>> =

>> I am with you that this needs to be documented better than GIT commit
>> logs.
>> =

>> However I do prefer doc/calypso-modem.txt and doc/ifx-modem.txt though
>> since I don't wanna clutter the root directory.
>> =

>
> Sounds good to me.

Cool.  Once I've worked out the simplest udev rule for calypso, I'll
submit a patch to create doc/calypso-modem.txt to document that.

(I don't yet understand why it makes sense for calypso to be handled
differently from other cases in plugins/ofono.rules, but I'm happy to
trust that there is a good reason for this.)

Regards,
       Neil

--===============2665872216241365462==--

