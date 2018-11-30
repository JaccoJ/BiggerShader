using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class shaderstuff : MonoBehaviour {

    public float speed = 5;
    public Material myMaterial;
    private Rigidbody rb;
    private float Size;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

   

        void Update()
    {
        var x = Input.GetAxis("Horizontal") * Time.deltaTime * 150.0f;
        var z = Input.GetAxis("Vertical") * Time.deltaTime * 3.0f;

        transform.Rotate(0, x, 0);
        transform.Translate(0, 0, z);

        SizeIncrease();
    }

    void SizeIncrease()
    {

       
        myMaterial.SetFloat("_Amount", Size);
    }

    void OnCollisionEnter(Collision col)
    {
        if(col.gameObject.tag == "Pickup")
        {
            print("asda");
            Size += 0.05f;
            Destroy(col.gameObject);
        }
    }
}
