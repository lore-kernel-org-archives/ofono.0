Content-Type: multipart/mixed; boundary="===============0686705907671257568=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC patches 06/13] smutil.h: add missing header file dependencies
Date: Fri, 28 May 2010 09:31:42 -0500
Message-ID: <201005280931.42298.denkenz@gmail.com>
In-Reply-To: <4304def8734a39650175fd6765317d1c70b0beba.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0686705907671257568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +#include <glib/gtypes.h>
> +#include <glib/gslist.h>
> +#include <glib/gmessages.h>
> +#include <glib/gchecksum.h>

Isn't it sufficient to just add glib/glib.h here?

Regards,
-Denis

--===============0686705907671257568==--

