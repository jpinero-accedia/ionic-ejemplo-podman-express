import { Router } from "express";

const router = Router();

router.get('/:receta', (req,res) => {
    res.json({
        id: req.params.receta,
        name: 'Tiramisu'
    });
} );

router.get('/:receta/ingrediente/:ingrediente', (req,res) => {
    res.json({
        id: req.params.ingrediente,
        recetaId: req.params.receta,
        name: 'café'
    });
} );

export default router;
