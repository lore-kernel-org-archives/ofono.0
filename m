Content-Type: multipart/mixed; boundary="===============6974202580579101474=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] configure: Bump glib dependecy to 2.32
Date: Tue, 26 Apr 2016 08:11:32 -0500
Message-ID: <571F6904.4070701@gmail.com>
In-Reply-To: <1444edf3-d876-9dd1-0cd2-0a84ed8760a2@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6974202580579101474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 04/26/2016 02:39 AM, Daniel Wagner wrote:
> On 04/26/2016 08:19 AM, John Ernberg wrote:
>
>> -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28, dummy=3Dyes,
>> -				AC_MSG_ERROR(GLib >=3D 2.28 is required))
>> +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
>> +				AC_MSG_ERROR(GLib >=3D 2.32 is required))
>
> Some time ago we had a discussion on the ConnMan mailing list doing the
> same thing. IIRC, 2.32 has a larger memory footprint compared to 2.28.
> That was an issue back than. Don't know if that is still relevant.
>

Yes, that is a good point.  Still, I don't think it makes sense to try =

and depend on a version from 2011.  Newer glib versions are even worse.

Our goal is to migrate oFono away from glib and onto ell, which is the =

proper solution to the footprint problem long-term.

Regards,
-Denis


--===============6974202580579101474==--

