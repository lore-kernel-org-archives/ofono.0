Content-Type: multipart/mixed; boundary="===============6915629303193644237=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/6] stkutil: Move advance of ctlv to decicated proactive
 commands parser
Date: Mon, 26 Apr 2010 16:53:34 +0200
Message-ID: <i2nfb249edb1004260753u2ddb4067g6f136c918f9bec09@mail.gmail.com>
In-Reply-To: <1272277766-25432-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6915629303193644237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 26 April 2010 12:29, Yang Gu <yang.gu@intel.com> wrote:
> Not all the proactive commands have comprehension tlv other than command
> details and device identities. So the appropriate code should be moved to
> decicated parser if needed.

Maybe parse_dataobj() would be a better place?

Regards

--===============6915629303193644237==--

