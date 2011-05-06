Content-Type: multipart/mixed; boundary="===============8979185114019713667=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unint var with GCC 4.5.2
Date: Thu, 05 May 2011 21:25:34 -0500
Message-ID: <4DC35C1E.80709@gmail.com>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75C5086A2D@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8979185114019713667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> =

> The unint var is =E2=80=98unsigned short iidf_id;=E2=80=99
> =

> If the image is in the cache, we will go to the watch directly, and if
> there is no watch, we will add one with an invalid iidf_id.
> =


This is a bug.  We need to add a watch to the proper iidf_id, which we
need to obtain from the EFimg look up table.  In the case of a cached
image, we're not doing that.

> So is it possible to have an image in the cache without watch?

Yes, the cache is persistent (stored in IMSI-keyed filesystem location).
 The logic is supposed to work somewhat like this:

1. Upon sim-atom init, read EFimg and populate its contents in a look up
table.

2a. When an application requests an icon with a particular id, look it
up in cache or read it from the SIM.  Each icon is assigned to a
particular EFiidf_n file.  So record application's interest in that file
by assigning a file watch.

2b. If an EFiidf file is refreshed via STK Refresh, call the file watch
and remove the file watch.  The file watch will be re-added again once
the application requests the icon.

However, we have not seen any SIMs with SIM icons, so this part of the
code has not been stress tested...

Regards,
-Denis

--===============8979185114019713667==--

