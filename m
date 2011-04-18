Content-Type: multipart/mixed; boundary="===============6390683089267877481=="
MIME-Version: 1.0
From: Rishi Kumar <crystal.rishi2@gmail.com>
Subject: SIM Cached Files
Date: Mon, 18 Apr 2011 16:11:52 +0530
Message-ID: <BANLkTinUHJusBA0KxnTT1d-=-vfGNGEU4g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6390683089267877481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was browsing the code but I could get a clear picture of what all
sim files are getting cached by ofono?

I could see the following enumeration and it being used in
ofono_sim_read(). Are all these files getting cached. ??

enum sim_fileid {
        SIM_EFPL_FILEID =3D                       0x2F05,
        SIM_EF_ICCID_FILEID =3D                   0x2FE2,
        SIM_MF_FILEID =3D                         0x3F00,
        SIM_EFIMG_FILEID =3D                      0x4F20,
        SIM_EFPSC_FILEID =3D                      0x4F22,
        SIM_EFCC_FILEID =3D                       0x4F23,
        SIM_EFPUID_FILEID =3D                     0x4F24,
        SIM_EFPBR_FILEID =3D                      0x4F30,
        SIM_DFPHONEBOOK_FILEID =3D                0x5F3A,
        SIM_DFMULTIMEDIA_FILEID =3D               0x5F3B,
        SIM_EFLI_FILEID =3D                       0x6F05,
        SIM_EFARR_FILEID =3D                      0x6F06,
        SIM_EFIMSI_FILEID =3D                     0x6F07,
        SIM_EF_CPHS_MWIS_FILEID =3D               0x6F11,
        SIM_EF_CPHS_CFF_FILEID =3D                0x6F13,
        SIM_EF_CPHS_CSP_FILEID =3D                0x6F15,
        SIM_EF_CPHS_INFORMATION_FILEID =3D        0x6F16,
        SIM_EF_CPHS_MBDN_FILEID =3D               0x6F17,
        SIM_EFUST_FILEID =3D                      0x6F38,
        SIM_EFSST_FILEID =3D                      0x6F38, /* same as EFust =
*/
        SIM_EFADN_FILEID =3D                      0x6F3A,
        SIM_EFMSISDN_FILEID =3D                   0x6F40,
        SIM_EFSMSP_FILEID =3D                     0x6F42,
        SIM_EFCBMI_FILEID =3D                     0x6F45,
        SIM_EFSPN_FILEID =3D                      0x6F46,
        SIM_EFCBMID_FILEID =3D                    0x6F48,
        SIM_EFSDN_FILEID =3D                      0x6F49,
        SIM_EFEXT1_FILEID =3D                     0x6F4A,
        SIM_EFBDN_FILEID =3D                      0x6F4D,
        SIM_EFCBMIR_FILEID =3D                    0x6F50,
        SIM_EFEST_FILEID =3D                      0x6F56,
        SIM_EFAD_FILEID =3D                       0x6FAD,
        SIM_EFPHASE_FILEID =3D                    0x6FAE,
        SIM_EFECC_FILEID =3D                      0x6FB7,
        SIM_EFPNN_FILEID =3D                      0x6FC5,
        SIM_EFOPL_FILEID =3D                      0x6FC6,
        SIM_EFMBDN_FILEID =3D                     0x6FC7,
        SIM_EFMBI_FILEID =3D                      0x6FC9,
        SIM_EFMWIS_FILEID =3D                     0x6FCA,
        SIM_EFCFIS_FILEID =3D                     0x6FCB,
        SIM_EFSPDI_FILEID =3D                     0x6FCD,
        SIM_DFTELECOM_FILEID =3D                  0x7F10,
        SIM_DFGSM_FILEID =3D                      0x7F20,
};


I could not also locate the meaning of STORAGEDIR. Kindly help me out
on the same.

Regards,
Rishi

--===============6390683089267877481==--

