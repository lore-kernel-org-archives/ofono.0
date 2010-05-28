Content-Type: multipart/mixed; boundary="===============7662858289137590881=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC patches 04/13] sms_assembly_add_fragment_backup: clarify how
 insertion spot is found
Date: Fri, 28 May 2010 09:27:20 -0500
Message-ID: <201005280927.20936.denkenz@gmail.com>
In-Reply-To: <8068e20eb9e130e16487497fe6098c2f44f273e0.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7662858289137590881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +		/* Iterate over the bitmap to find in which position
> +		 * should the fragment be inserted -- basically we
> +		 * walk each bit in the bitmap until the bit we care
> +		 * about (offset:bit) and count which are stored --
> +		 * that gives us in which position we have to insert. */

Patch has been applied.  However please keep your commit header to 50 =

characters or less.  Also, the preferred style for multi-line comments is:
/* <empty line>
 * ... comment
 */

Regards,
-Denis

--===============7662858289137590881==--

