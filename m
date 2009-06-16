Content-Type: multipart/mixed; boundary="===============1485064561902079798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Network registeration mode
Date: Tue, 16 Jun 2009 10:38:49 -0500
Message-ID: <200906161038.49954.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C130203DA1B52@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1485064561902079798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tuesday 16 June 2009 03:25:17 Li, Zhigang wrote:
> Hi All,
> About the Mode properties in NetworkRegistration, if we don't provide wri=
te
> attributes how user can register the network manually? I saw there was
> SetProperty Methods but removed now.

Manual registration is accomplished by using the Register method on the =

NetworkOperator interface.

Regards,
-Denis

--===============1485064561902079798==--

