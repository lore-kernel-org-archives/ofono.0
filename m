Content-Type: multipart/mixed; boundary="===============0420314504982875282=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Fix Use hashtable to record udev path
Date: Tue, 11 May 2010 09:21:10 -0500
Message-ID: <201005110921.10985.denkenz@gmail.com>
In-Reply-To: <1273539869-23803-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0420314504982875282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Sometimes, Udev device 'remove' event could not report correct parent
> node of current udev_device. Current code replies on the devpath
> attached on the parent node to find modem and then remove it.
> =

> This fix is to change the way to store the devpath info into a
> hashtable. So that we search hashtable to get devpath and remove the
> modem.

Patch has been applied, thanks.

Regards,
-Denis

--===============0420314504982875282==--

