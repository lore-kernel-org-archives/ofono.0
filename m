Content-Type: multipart/mixed; boundary="===============3001867589832654992=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] coex: Adding coex includes for coex atom
Date: Mon, 01 Oct 2018 14:59:51 -0500
Message-ID: <de6981f2-68ac-ba47-199c-fc34488104af@gmail.com>
In-Reply-To: <1538390022-6183-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3001867589832654992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 10/01/2018 05:33 AM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> Added coex.h which describes the includes of coex atom
> ---
>   include/coex.h | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 119 insertions(+)
>   create mode 100644 include/coex.h
> =


Since this is going to be Intel modem specific, and will be implemented =

inside the modem driver, I don't think we really need a driver =

abstraction at all, right?  E.g. can't we just send AT commands directly =

from the modem driver similar to how ril_intel.c's thermal stuff is done?

Regards,
-Denis

--===============3001867589832654992==--

