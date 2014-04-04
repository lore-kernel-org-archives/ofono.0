Content-Type: multipart/mixed; boundary="===============2238961353381682529=="
MIME-Version: 1.0
From: Antti =?unknown-8bit?q?Kaijanm=C3=A4ki?= <antti.kaijanmaki@canonical.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Fri, 04 Apr 2014 03:22:23 +0300
Message-ID: <533DFB3F.6080802@canonical.com>
In-Reply-To: <533DD568.9080807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2238961353381682529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04.04.2014 00:40, Denis Kenzior wrote:
> Phonesim can have an arbitrary number of instances (I once tested 100 at
> once), and one can assign an object path using phonesim.conf.  Your test
> application can then find such groupings and accomplish essentially the
> same thing as you're trying to do now.

What we are trying to do is a full stack system testing where the
individual components that are being tested don't have any modifications
or adaptations when they are run under test suite.

The number of modems returned by org.ofono.Manager.GetModems() must
represent the total number of modems available to the system and thus we
need to have exactly two modems when testing dual-sim features etc.

The need to change the number of modems during testing comes from the
fact that our test suite has the single and multimodem tests together
and runs them one after another and we need to be able to set up the
environment appropriately in between individual test cases.

 -- Antti


--===============2238961353381682529==--

