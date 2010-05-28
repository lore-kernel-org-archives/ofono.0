Content-Type: multipart/mixed; boundary="===============8592824347819474659=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 06/13] smutil.h: add missing header file dependencies
Date: Fri, 28 May 2010 16:19:16 +0200
Message-ID: <1275056356.4706.78.camel@aeonflux.t-mobile.de>
In-Reply-To: <4304def8734a39650175fd6765317d1c70b0beba.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8592824347819474659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> diff --git a/src/smsutil.h b/src/smsutil.h
> index 469a49e..356ec5d 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -18,6 +18,14 @@
>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
>   *
>   */
> +#ifndef __smsutil_h__
> +#define __smsutil_h__

please leave the circular dependency protection out here. I really want
it to fail if we go so crazy and would require it.

Regards

Marcel



--===============8592824347819474659==--

