Content-Type: multipart/mixed; boundary="===============2374431271959202184=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Reorder statements to make SIM op queue more robust.
Date: Fri, 07 Aug 2009 15:50:59 -0500
Message-ID: <200908071550.59955.denkenz@gmail.com>
In-Reply-To: <1249590552-18714-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2374431271959202184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> This allows ofono_sim_read and ofono_sim_write callbacks to queue new
> read or write operations.  The callback must not be called between
> removing the operation from queue and checking queue length.

Patch has been applied.  Thanks.

Regards,
-Denis


--===============2374431271959202184==--

