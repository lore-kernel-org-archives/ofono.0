Content-Type: multipart/mixed; boundary="===============4509984504442672885=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 0/2] Telit LE910 V1 QMI support
Date: Fri, 24 Mar 2017 10:11:34 -0500
Message-ID: <f7077051-c018-ceaa-5b84-b6154fd3ac04@gmail.com>
In-Reply-To: <1490367106-8401-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4509984504442672885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/24/2017 09:51 AM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Changes from V2:
> - made AlwaysOnline flow cleaner in gobi.c
> - it turns out that AlwaysOnline is already a part of core logic
>   in src/modem.c which have the same effect as if the driver had
>   no set_online() function at all. Hence removed changes to
>   gobi_set_online() as it is never called.
>

Ah yes, I completely forgot that someone added the AlwaysOnline override =

so you didn't need to implement a brand new driver without .set_online =

implemented.  Good that you discovered that, sorry for the confusion.

Regards,
-Denis


--===============4509984504442672885==--

