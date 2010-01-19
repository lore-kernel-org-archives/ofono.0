Content-Type: multipart/mixed; boundary="===============4788945284952066270=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 3/7] STE-plugin: Add vendor STE and quirks in atmodem.
Date: Tue, 19 Jan 2010 11:17:45 -0800
Message-ID: <1263928665.5591.177.camel@localhost.localdomain>
In-Reply-To: <1263917513-6756-3-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4788945284952066270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Added STE as vendor and quirks needed in "atmodem" for ST-Ericsson modem.
> Added at_util_call_compare_by_id

please put the addition of at_util_call_compare_by_id in a separate
patch. It doesn't really belong here.

The rest looks fine to me. Except that you are using hardcoded CIND
indexes. That is acceptable for the first inclusion, but we expect you
to fix that in an update.

So if you split this into two patches re-submit then, then I see no
problem in applying them.

Regards

Marcel



--===============4788945284952066270==--

