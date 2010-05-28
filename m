Content-Type: multipart/mixed; boundary="===============1387590681815153211=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Patch]: Reducing clutter in the src directory + Introduction of
 HACKING file
Date: Fri, 28 May 2010 04:46:08 +0200
Message-ID: <1275014768.4706.57.camel@aeonflux.t-mobile.de>
In-Reply-To: <AANLkTimNoqUOmIfT0Lh_zKic6T-PGWAB9PyZxXrXpl98@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1387590681815153211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

> I have re-organized the directory structure inside phonesim for easy
> management of respective files. Everything was in src directory and as
> the simulator will grow in functionality, it will become all the more
> cluttered and not so pretty to handle. I have updated the Makefile.am
> to reflect the changes and have also tested most of the phonesim
> functionality.

actually all the includes are local to phonesim and that is why they are
inside the src/ directory.

I also don't see the clutter you are talking about. The *.h are named
the same as their *.cpp files and are side by side. I actually call that
pretty clean.

> I have also added a HACKING file for people to quickly understand and
> grasp the concept and execution of phonesim.

Please send that as a separate patch.

Regards

Marcel



--===============1387590681815153211==--

