Content-Type: multipart/mixed; boundary="===============8807082809061729994=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [SMS D-Bus 03/23] smutil.h: add missing header file dependencies
Date: Sat, 26 Jun 2010 01:48:29 +0200
Message-ID: <1277509709.2330.146.camel@localhost.localdomain>
In-Reply-To: <7356379c8adb4d93335cae5e9ab75d0684b93321.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8807082809061729994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

>  src/smsutil.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/src/smsutil.h b/src/smsutil.h
> index 66ef6f8..baa3eca 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -18,6 +18,14 @@
>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
>   *
>   */
> +#ifndef __smsutil_h__
> +#define __smsutil_h__

for internal headers I don't want the circular inclusion protection. It
buys us nothing. And leaving it out will warn us when we do circular
inclusion. That is a clear indication that something is a bit too
complicated if it is needed.

Regards

Marcel



--===============8807082809061729994==--

