Content-Type: multipart/mixed; boundary="===============3256518826848957405=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 01/27] stk: Add poll interval proactive command parser
Date: Fri, 14 May 2010 16:37:02 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731DE71DFE@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201005131537.46302.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3256518826848957405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
	I rethink about my second question (parse_dataobj() shouldn't eat the cake=
 that not belongs to it) on IRC, and may find a case to defense my point.
	The example is ber-tlv launch browser. The similarity to setup_menu is tha=
t they all contain a list, while the difference is the list in lanuch brows=
er is optional. Below are the objects within launch browser: browser id(M),=
 URL(O), bearer(O),provisioning file 1(O), provisioning file 2(O),...,provi=
sioning file N(O), text string(O), ...
	Then we may call parse_dataobj(browser id, URL, bearer) to parse the objec=
ts before provisioning files, then use parse_provisioning_file_list() to pa=
rse provisioning files, and at last call parse_dataobj() again to parse the=
 rest. If there is no provisioning file at all, the situation is same to ca=
ll parse_dataobj() one after another. If so, we may read object text string=
 in first parse_dataobj(), and at the beginning of second parse_dataobj(), =
we would move forward again, which could be wrong.
	Thus I think the solution is parse_dataobj() needs to restore the iter it =
can't consume. What's your opinion?

Regards,
-Yang


--===============3256518826848957405==--

