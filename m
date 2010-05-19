Content-Type: multipart/mixed; boundary="===============3468532764051230805=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: commit "Fix Use hashtable to record udev path" breaks huawei
Date: Wed, 19 May 2010 16:19:56 +0300
Message-ID: <87tyq46nb7.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3468532764051230805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

while working on third version of my huawei gprs patches I noticed that
this commit breaks huawei:

commit af976f7e524746b1b55645967e11ab8250f593a8
Author: Zhenhua Zhang <zhenhua.zhang@intel.com>
Date:   Tue May 11 09:04:28 2010 +0800

    Fix Use hashtable to record udev path
    =

    Sometimes, Udev device 'remove' event could not report correct parent
    node of current udev_device. Current code replies on the devpath
    attached on the parent node to find modem and then remove it.
    =

    This fix is to change the way to store the devpath info into a
    hashtable. So that we search hashtable to get devpath and remove the
    modem.

I reverted the commit and huawei works again for me. More details later
today.

-- =

Kalle Valo

--===============3468532764051230805==--

