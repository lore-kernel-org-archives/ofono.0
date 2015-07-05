Content-Type: multipart/mixed; boundary="===============0974054407275501575=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bug in oFono 1.15+  Handsfree GetProperties()
Date: Sun, 05 Jul 2015 06:07:46 -0500
Message-ID: <55991002.4000006@gmail.com>
In-Reply-To: <E541850BD1A4194EB55388101C8C0DF37A5F8D76CB@MXCL03.fgremc.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0974054407275501575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On 07/06/2015 11:38 AM, BARDEN Christopher (MM) wrote:
> Hello,
>
> Using the DBus API, I noticed that the first call to GetProperties() in
> the Handsfree interface always fails with an =E2=80=9CInProgress=E2=80=9D=
 error.  I have
> verified that this behavior isn=E2=80=99t there in 1.14, but does seem to=
 be in
> both 1.15 and 1.16.  Any subsequent calls to GetProperties() are
> successful and return the properties of that interface successfully.  I
> couldn=E2=80=99t find a bug tracker to submit this to, so I thought this =
would
> be the most appropriate place.  What is your recommendation for working
> around this issue?

Looks like someone forgot to mark the GetProperties method as ASYNC =

which might cause this.

Try git commit 454b7e63e38b8df034a3c5e1d9b8562ca92ceb0b to see if it =

fixes this issue.

The very first call to GetProperties triggers a +CNUM query to the =

driver.  Once the query is performed, the results are cached and the =

reply is returned.  All subsequent replies will be generated on the =

cached results.  If you have multiple clients that are trying to utilize =

GetProperties during the initial query time, then all-but-one will =

receive an InProgress error.

Here's the commit for reference:

diff --git a/src/handsfree.c b/src/handsfree.c

  static const GDBusMethodTable handsfree_methods[] =3D {
-       { GDBUS_METHOD("GetProperties",
+       { GDBUS_ASYNC_METHOD("GetProperties",
                         NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
                         handsfree_get_properties) },
         { GDBUS_ASYNC_METHOD("SetProperty",

Regards,
-Denis

--===============0974054407275501575==--

